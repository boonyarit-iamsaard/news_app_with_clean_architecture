import 'package:go_router/go_router.dart';

import '../../domain/models/article.dart';
import '../../presentation/views/article_details_view.dart';
import '../../presentation/views/breaking_news_view.dart';
import '../../presentation/views/saved_articles_views.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            name: 'breaking-news',
            path: '/',
            builder: (context, state) => const BreakingNewsView(),
          ),
          GoRoute(
            name: 'article-details',
            path: '/article-details',
            builder: (context, state) {
              final article =
                  (state.extra as Map<String, dynamic>)['article'] as Article;

              return ArticleDetailsView(article: article);
            },
          ),
          GoRoute(
            name: 'saved-articles',
            path: '/saved-articles',
            builder: (context, state) => const SavedArticlesView(),
          )
        ],
      );
}
