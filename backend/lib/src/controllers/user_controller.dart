import 'package:backend/src/domain/entities/user.dart';
import 'package:backend/src/domain/usecases/get_user_usecase.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Api(tag: 'User', description: 'User Controller')
@Controller('/user')
class UserController {
  final GetUser _getUser;

  UserController(this._getUser);

  @ApiOperation(summary: 'Get user', description: 'Get user informations')
  @ApiResponse(
    200,
    description: 'User informations',
    content: ApiContent(type: 'application/json', schema: User),
  )
  @Get('/')
  Future<User> getUser() async {
    return await _getUser('id').getOrThrow();
  }
}
