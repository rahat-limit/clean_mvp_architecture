import 'package:clean_mvp_architecture/data/models/post_model.dart';

class PostState {
  final List<PostModel> posts;
  final PostStatus status;
  const PostState({required this.posts, required this.status});

  PostState copyWith({List<PostModel>? posts, PostStatus? status}) {
    return PostState(posts: posts ?? this.posts, status: status ?? this.status);
  }
}

abstract class PostStatus {}

class InitPostStatus extends PostStatus {}

class OkPostStatus extends PostStatus {}

class LoadingPostStatus extends PostStatus {}

class ErrorPostStatus extends PostStatus {}
