import 'package:flutter/material.dart';
import 'package:news_app_with_clean_architecture/src/config/router/app_router.dart';
import 'package:news_app_with_clean_architecture/src/config/theme/app_theme.dart';
import 'package:news_app_with_clean_architecture/src/core/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: AppTheme.light,
      routerConfig: _appRouter.router,
      routerDelegate: _appRouter.router.routerDelegate,
      routeInformationParser: _appRouter.router.routeInformationParser,
    );
  }
}
