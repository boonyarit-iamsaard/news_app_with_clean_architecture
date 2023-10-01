part of 'local_articles_cubit.dart';

sealed class LocalArticlesState extends Equatable {
  final List<Article> articles;

  const LocalArticlesState({
    this.articles = const [],
  });

  @override
  List<Object> get props => [articles];
}

final class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

final class LocalArticlesSuccess extends LocalArticlesState {
  const LocalArticlesSuccess({super.articles});
}
