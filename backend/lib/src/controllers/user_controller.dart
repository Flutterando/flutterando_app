import 'package:backend/src/domain/dto/user/user_create_dto.dart';
import 'package:backend/src/domain/dto/user/user_update_dto.dart';
import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';
import 'package:vaden_security/vaden_security.dart';

import '../domain/dto/email_otp_verification_dto.dart';
import '../domain/dto/user/user_dto.dart';
import '../domain/usecases/user/authentication_via_recovery_usecase.dart';
import '../domain/usecases/user/create_user_usecase.dart';
import '../domain/usecases/user/create_user_verify_usecase.dart';
import '../domain/usecases/user/get_users_usecase.dart';
import '../domain/usecases/user/send_recover_email_usecase.dart';
import '../domain/usecases/user/update_user_usecase.dart';

@Api(tag: 'User', description: 'User Controller')
@Controller('/user')
class UserController {
  final GetUsers _getUsers;
  final CreateUser _createUser;
  final CreateUserVerify _createUserVerify;
  final UpdateUser _updateUser;
  final SendRecoverPasswordEmail _sendRecoverPasswordEmail;
  final AuthenticationViaRecoveryCode _authenticationViaRecoveryCode;

  UserController(
    this._getUsers,
    this._createUser,
    this._createUserVerify,
    this._updateUser,
    this._sendRecoverPasswordEmail,
    this._authenticationViaRecoveryCode,
  );

  @ApiOperation(summary: 'Get user', description: 'Get user informations')
  @ApiResponse(
    200,
    description: 'User informations',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Get()
  User getUser(@Context('user') User user) {
    return user;
  }

  @ApiOperation(summary: 'Create a user', description: 'Create a new user')
  @ApiResponse(
    202,
    description: 'Create a user',
  )
  @Post()
  Future<Response> createUser(@Body() UserCreateDto dto) async {
    return await _createUser(dto) //
        .flatMap((_) => Success(Response(202)))
        .getOrThrow();
  }

  @ApiOperation(summary: 'Update user', description: 'Update user informations')
  @ApiResponse(
    200,
    description: 'Update User',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Put()
  Future<User> updateUser(
      @Body() UserUpdateDTO dto, @Context('user') User user) async {
    return await _updateUser(dto: dto, user: user).getOrThrow();
  }

  @ApiOperation(
      summary: 'Email verification',
      description: 'Email verification to create a new user')
  @ApiResponse(
    200,
    description: 'Create a user',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Post('/verify')
  Future<User> createUserVerify(@Body() EmailOtpVerificationDTO dto) async {
    return await _createUserVerify(dto).getOrThrow();
  }

  @ApiOperation(
      summary: 'Password recovery request',
      description: 'Send an email with a recovery code')
  @Get('/recovery/<email>')
  Future<Response> sendRecoveryEmail(@Param('email') String email) async {
    return await _sendRecoverPasswordEmail(email) //
        .flatMap((_) => Success(Response(202)))
        .getOrThrow();
  }

  @ApiOperation(
      summary: 'Authentication via recovery',
      description: 'Authentication using a recovery code')
  @ApiResponse(
    200,
    description: 'Authentication via recovery',
    content: ApiContent(type: 'application/json', schema: Tokenization),
  )
  @Post('/recovery')
  Future<Tokenization> authenticationViaRecovery(
      @Body() EmailOtpVerificationDTO dto) async {
    return await _authenticationViaRecoveryCode(dto).getOrThrow();
  }

  @ApiOperation(
      summary: 'Get users', description: 'Get list of user informations')
  @ApiResponse(
    200,
    description: 'User informations',
    content: ApiContent(type: 'application/json', schema: List<User>),
  )
  @Get('/admin')
  Future<List<User>> getAdminUser(
      @Query('email') String? email, @Context('user') User user) async {
    if (user.isAdmin()) {
      return await _getUsers(email: email).getOrThrow();
    }

    throw ResponseException.forbidden('Without authorization');
  }

  @ApiOperation(summary: 'Update user', description: 'Update user informations')
  @ApiResponse(
    200,
    description: 'Update User',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Put('/admin')
  Future<User> updateAdminUser(
      @Body() UserDTO dto, @Context('user') User user) async {
    if (user.isAdmin()) {
      return await _updateUser(dto: dto).getOrThrow();
    }

    throw ResponseException.forbidden('Without authorization');
  }
}
