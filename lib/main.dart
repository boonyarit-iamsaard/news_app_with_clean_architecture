import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/router/app_router.dart';
import 'src/config/theme/app_theme.dart';
import 'src/core/utils/constants/constants.dart';
import 'src/domain/repositories/api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/remote_articles/remote_articles_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteArticlesCubit(
            locator<ApiRepository>(),
          )..getBreakingNews(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: AppTheme.light,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
