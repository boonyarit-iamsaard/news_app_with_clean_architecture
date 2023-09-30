import 'package:go_router/go_router.dart';

import '../../presentation/views/breaking_news_view.dart';

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
