import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteArticlesCubit.getBreakingNews();
      });

      return scrollController.dispose;
    }, const []);

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
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Icon(
                Icons.bookmark,
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
                  icon: const Icon(Icons.refresh),
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
