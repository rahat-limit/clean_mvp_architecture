import 'package:clean_mvp_architecture/global/states/posts_state.dart';
import 'package:clean_mvp_architecture/interfaces/posts_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  // Статические методы для прослушивания и получения кубита
  static PostState watchState(BuildContext context) =>
      context.watch<PostCubit>().state;
  static PostCubit read(BuildContext context) => context.read<PostCubit>();

  PostCubit({required PostRepository repository})
      : _repository = repository,
        super(PostState(posts: [], status: InitPostStatus()));

  final PostRepository _repository;

  void fetchPosts() async {
    try {
      emit(state.copyWith(status: LoadingPostStatus()));
      final posts = await _repository.fetchPosts();
      print(posts.posts);
      emit(state.copyWith(posts: posts.posts, status: OkPostStatus()));
    } on DioException catch (e) {
      print(e);
    }
  }
}
