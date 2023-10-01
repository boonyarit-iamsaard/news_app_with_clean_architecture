import '../../domain/models/article.dart';
import '../../domain/repositories/database_repository.dart';
import '../datasources/local/app_database.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<Article>> getArticles() async {
    return await _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> saveArticle(Article article) async {
    await _appDatabase.articleDao.saveArticle(article);
  }

  @override
  Future<void> deleteArticle(Article article) async {
    await _appDatabase.articleDao.deleteArticle(article);
  }
}
