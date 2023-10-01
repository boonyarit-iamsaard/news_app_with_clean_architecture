import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/utils/extensions/scroll_controller_extension.dart';
import '../../domain/models/article.dart';
import '../cubits/remote_articles/remote_articles_cubit.dart';
import '../widgets/article_widget.dart';

class BreakingNewsView extends HookWidget {
  const BreakingNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();

    scrollController.onScrollEndsListener(() {
      remoteArticlesCubit.getBreakingNews();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              context.goNamed('saved-articles');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Ionicons.bookmark,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteArticlesLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RemoteArticlesFailed:
              return Center(
                child: IconButton(
                  icon: const Icon(Ionicons.refresh),
                  onPressed: () {
                    remoteArticlesCubit.getBreakingNews();
                  },
                ),
              );
            case RemoteArticlesSuccess:
              return _buildArticles(
                scrollController,
                state.articles,
                state.noMoreData,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticles(
    ScrollController scrollController,
    List<Article> articles,
    bool noMoreData,
  ) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ArticleWidget(
              article: articles[index],
              onArticlePressed: (article) {
                context.goNamed('article-details', extra: {'article': article});
              },
            ),
            childCount: articles.length,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 14,
                bottom: 32,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }
}
