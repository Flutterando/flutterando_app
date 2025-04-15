import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../domain/dto/posts_create_dto.dart';
import '../domain/dto/posts_update_dto.dart';
import '../domain/entities/post.dart';
import '../domain/usecases/posts/create_posts_usecase.dart';
import '../domain/usecases/posts/get_posts_usecase.dart';
import '../domain/usecases/posts/update_posts_usecase.dart';
import '../domain/validations/create_posts_validation.dart';
import '../domain/validations/update_posts_validation.dart';
import '../domain/value_objects/posts_vo.dart';

@Api(tag: 'Posts', description: 'Posts Controller')
@Controller('/posts')
class PostsController {
  final GetPosts _getPosts;
  final CreatePosts _createPosts;
  final UpdatePosts _updatePosts;
  final CreatePostsValidation _createPostsValidatorn;
  final UpdatePostsValidation _updatePostsValidation;

  PostsController(
    this._getPosts,
    this._createPosts,
    this._updatePosts,
    this._createPostsValidatorn,
    this._updatePostsValidation,
  );

  @ApiOperation(summary: 'Get Posts page', description: 'Get Posts whit pages')
  @ApiResponse(
    200,
    description: 'Posts page List',
    content: ApiContent(type: 'application/json', schema: PostsVO),
  )
  @Get()
  Future<PostsVO> getUser(@Query('page') int? page) async {
    return await _getPosts(page ?? 1).getOrThrow();
  }

  @ApiOperation(summary: 'Create post', description: 'Create a new post')
  @ApiResponse(
    200,
    description: 'Create a new post',
    content: ApiContent(type: 'application/json', schema: Posts),
  )
  @Post()
  Future<Posts> createUser(
      @Body() PostsCreateDTO dto, @Context('user') User user) async {
    final validationResult = _createPostsValidatorn
        .validate(ValidatorBuilder<PostsCreateDTO>())
        .validate(dto);

    if (!validationResult.isValid) {
      throw ResponseException(
          422, {'errors': validationResult.exceptionToJson()});
    }

    return await _createPosts(dto: dto, user: user).getOrThrow();
  }

  @ApiOperation(summary: 'Update post', description: 'Update post informations')
  @ApiResponse(
    200,
    description: 'Update post',
    content: ApiContent(type: 'application/json', schema: Posts),
  )
  @Put()
  Future<Posts> updateUser(
      @Body() UpdatePostsDTO dto, @Context('user') User user) async {
    final validationResult = _updatePostsValidation
        .validate(ValidatorBuilder<UpdatePostsDTO>())
        .validate(dto);

    if (!validationResult.isValid) {
      throw ResponseException(
          422, {'errors': validationResult.exceptionToJson()});
    }

    return await _updatePosts(dto: dto, user: user).getOrThrow();
  }
}
