import 'package:backend/src/domain/entities/user.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

import '../domain/dto/posts/posts_create_dto.dart';
import '../domain/dto/posts/posts_update_dto.dart';
import '../domain/entities/post.dart';
import '../domain/usecases/posts/create_posts_usecase.dart';
import '../domain/usecases/posts/get_posts_usecase.dart';
import '../domain/usecases/posts/update_posts_usecase.dart';
import '../domain/value_objects/posts_vo.dart';

@Api(tag: 'Posts', description: 'Posts Controller')
@Controller('/posts')
class PostsController {
  final GetPosts _getPosts;
  final CreatePosts _createPosts;
  final UpdatePosts _updatePosts;

  PostsController(
    this._getPosts,
    this._createPosts,
    this._updatePosts,
  );

  @ApiOperation(summary: 'Get Posts page', description: 'Get Posts whit pages')
  @ApiResponse(
    200,
    description: 'Posts page List',
    content: ApiContent(type: 'application/json', schema: PostsVO),
  )
  @Get()
  Future<PostsVO> getPosts(@Query('page') int? page) async {
    if (page != null && page <= 0) {
      throw ResponseException.badRequest('Invalid page');
    }

    return await _getPosts(page ?? 1).getOrThrow();
  }

  @ApiOperation(
      summary: 'Create post',
      description: 'Create a new post (only a creator users)')
  @ApiResponse(
    200,
    description: 'Create a new post',
    content: ApiContent(type: 'application/json', schema: Posts),
  )
  @Post()
  Future<Posts> createPosts(
      @Body() PostsCreateDTO dto, @Context('user') User user) async {
    if (!user.roles.contains('creator')) {
      throw ResponseException.forbidden('Only for content creators');
    }
    return await _createPosts(dto: dto, user: user).getOrThrow();
  }

  @ApiOperation(
      summary: 'Update post',
      description: 'Update post informations  (only a creator users)')
  @ApiResponse(
    200,
    description: 'Update post',
    content: ApiContent(type: 'application/json', schema: Posts),
  )
  @Put()
  Future<Posts> updatePosts(
      @Body() UpdatePostsDTO dto, @Context('user') User user) async {
    if (user.isCreator()) {
      return await _updatePosts(dto: dto, user: user).getOrThrow();
    }

    throw ResponseException.forbidden('Only for content creators');
  }
}
