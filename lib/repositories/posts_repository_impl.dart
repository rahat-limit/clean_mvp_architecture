import 'package:clean_mvp_architecture/data/local_db/token_storage.dart';
import 'package:clean_mvp_architecture/data/network/posts_api.dart';
import 'package:clean_mvp_architecture/data/response/post_response.dart';
import 'package:clean_mvp_architecture/interfaces/posts_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl extends PostRepository {
  final PostApi postsApi;
  final TokenStorage tokenStorage;

  PostRepositoryImpl({required this.postsApi, required this.tokenStorage});

  @override
  Future<PostResponse> fetchPosts() async {
    try {
      final result =
          await postsApi.fetchPosts('Token ${tokenStorage.token ?? ''}');
      return result;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
