import 'package:clean_mvp_architecture/data/response/post_response.dart';

abstract class PostRepository {
  Future<PostResponse> fetchPosts();
}
