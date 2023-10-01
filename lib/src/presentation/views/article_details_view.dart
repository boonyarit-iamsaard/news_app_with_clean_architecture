import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

import '../../domain/models/article.dart';
import '../cubits/local_articles/local_articles_cubit.dart';

class ArticleDetailsView extends HookWidget {
  final Article article;

  const ArticleDetailsView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalArticlesCubit localArticlesCubit =
        BlocProvider.of<LocalArticlesCubit>(context);

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.goNamed('breaking-news'),
            child: const Icon(
              Ionicons.chevron_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildArticleTitleAndDate(),
              _buildArticleImage(),
              _buildArticleDescription(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            localArticlesCubit.saveArticle(article);
            showToast('Article saved to local storage');
          },
          child: const Icon(
            Ionicons.bookmark,
            color: Colors.white,
          ),
        ));
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        '${article.description ?? ''}\n\n${article.content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        article.urlToImage ?? '',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Icon(
            Ionicons.image_outline,
            size: 50,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? '',
            style: const TextStyle(
              fontFamily: 'ReithSerif',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16),
              const SizedBox(width: 4),
              Text(
                article.publishedAt ?? '',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}
