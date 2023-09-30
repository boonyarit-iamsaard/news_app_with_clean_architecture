import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/extensions/scroll_controller_extension.dart';
import '../cubits/remote_articles/remote_articles_cubit.dart';

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
            onTap: () {
              context.goNamed('saved-articles');
            },
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
              return const Center(
                child: Text('Success'),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
