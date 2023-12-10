import 'package:clean_mvp_architecture/data/models/post_model.dart';
import 'package:clean_mvp_architecture/data/response/post_response.dart';
import 'package:dio/dio.dart';

part 'posts_api.g.dart';

abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  Future<PostResponse> fetchPosts(String token);
}
