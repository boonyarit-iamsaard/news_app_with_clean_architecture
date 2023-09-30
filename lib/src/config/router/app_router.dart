import 'package:go_router/go_router.dart';
import 'package:news_app_with_clean_architecture/src/presentation/views/breaking_news_view.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            name: 'breaking-news',
            path: '/',
            builder: (context, state) => const BreakingNewsView(),
          )
        ],
      );
}
