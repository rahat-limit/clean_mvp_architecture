import 'package:clean_mvp_architecture/global/cubits/posts_cubit.dart';
import 'package:clean_mvp_architecture/helpers/theme_notifier.dart';
import 'package:clean_mvp_architecture/repositories/posts_repository_impl.dart';
import 'package:clean_mvp_architecture/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  await sl.allReady();

  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(const AppSetup());
  });
}

class AppSetup extends StatelessWidget {
  const AppSetup({super.key});

  @override
  Widget build(BuildContext context) {
    // return App();
    return MultiBlocProvider(providers: [
      BlocProvider(
        lazy: false,
        create: (_) => PostCubit(repository: sl<PostRepositoryImpl>()),
      ),
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ThemeNotifier(themeStorage: sl())),
        ],
        builder: (context, child) {
          final themeMode = context.watch<ThemeNotifier>().getThemeMode;
          late ThemeData themeData;

          switch (themeMode) {
            case AppColorMode.dark:
              themeData = ThemeData.dark();
            case AppColorMode.light:
              themeData = ThemeData.light();
            default:
              themeData = ThemeData.light();
          }
          return MaterialApp(theme: themeData, home: const Home());
        });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final postState = PostCubit.read(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        // context.read<ThemeNotifier>().switchMode(AppColorMode.dark);
        postState.fetchPosts();
      }),
      appBar: AppBar(title: Text('token')),
    );
  }
}
