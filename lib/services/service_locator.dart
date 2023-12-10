import 'package:clean_mvp_architecture/data/local_db/token_storage.dart';
import 'package:clean_mvp_architecture/data/local_db/theme_storage.dart';
import 'package:clean_mvp_architecture/data/network/posts_api.dart';
import 'package:clean_mvp_architecture/global/cubits/posts_cubit.dart';
import 'package:clean_mvp_architecture/helpers/theme_notifier.dart';
import 'package:clean_mvp_architecture/repositories/posts_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerSingletonAsync(() async => await SharedPreferences.getInstance());

  Future.delayed(const Duration(seconds: 5));

  sl.registerLazySingleton<ThemeStorage>(() => ThemeStorage(prefs: sl()));
  sl.registerLazySingleton<ThemeNotifier>(
      () => ThemeNotifier(themeStorage: sl()));

  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(prefs: sl()));

  // API

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<PostApi>(
      () => PostApi(sl(), baseUrl: 'https://jsonplaceholder.typicode.com'));

  sl.registerLazySingleton<PostRepositoryImpl>(
      () => PostRepositoryImpl(postsApi: sl(), tokenStorage: sl()));
  sl.registerLazySingleton<PostCubit>(() => PostCubit(repository: sl()));
}
