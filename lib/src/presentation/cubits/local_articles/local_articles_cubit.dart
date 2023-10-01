import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/article.dart';
import '../../../domain/repositories/database_repository.dart';

part 'local_articles_state.dart';

class LocalArticlesCubit extends Cubit<LocalArticlesState> {
  final DatabaseRepository _databaseRepository;

  LocalArticlesCubit(this._databaseRepository)
      : super(const LocalArticlesLoading());

  Future<void> getArticles() async {
    emit(await _getArticles());
  }

  Future<void> saveArticle(Article article) async {
    await _databaseRepository.saveArticle(article);

    emit(await _getArticles());
  }

  Future<void> deleteArticle(Article article) async {
    await _databaseRepository.deleteArticle(article);

    emit(await _getArticles());
  }

  Future<LocalArticlesState> _getArticles() async {
    final articles = await _databaseRepository.getArticles();

    return LocalArticlesSuccess(articles: articles);
  }
}
