import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../domain/dto/user_dto.dart';
import '../domain/usecases/user/create_user_usecase.dart';
import '../domain/usecases/user/update_user_usecase.dart';
import '../domain/validations/create_user_validation.dart';
import '../domain/validations/update_user_validation.dart';

@Api(tag: 'User', description: 'User Controller')
@Controller('/user')
class UserController {
  final CreateUser _createUser;
  final UpdateUser _updateUser;
  final CreateUserValidator _createUserValidator;
  final UpdateUserValidation _updateUserValidation;

  UserController(
    this._createUser,
    this._updateUser,
    this._createUserValidator,
    this._updateUserValidation,
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
    200,
    description: 'Create a user',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Post()
  Future<User> createUser(@Body() UserDTO dto) async {
    final validationResult = _createUserValidator
        .validate(ValidatorBuilder<UserDTO>())
        .validate(dto);

    if (!validationResult.isValid) {
      throw ResponseException(
          422, {'errors': validationResult.exceptionToJson()});
    }

    return await _createUser(dto).getOrThrow();
  }

  @ApiOperation(summary: 'Update user', description: 'Update user informations')
  @ApiResponse(
    200,
    description: 'Update User',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Put()
  Future<User> updateUser(
      @Body() UserDTO dto, @Context('user') User user) async {
    final validationResult = _updateUserValidation
        .validate(ValidatorBuilder<UserDTO>())
        .validate(dto);

    if (!validationResult.isValid) {
      throw ResponseException(
          422, {'errors': validationResult.exceptionToJson()});
    }

    return await _updateUser(dto: dto, user: user).getOrThrow();
  }
}
