import 'package:floor/floor.dart';

import '../../../../core/utils/constants/constants.dart';
import '../../../../domain/models/article.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM $articlesTableName')
  Future<List<Article>> getArticles();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveArticle(Article article);

  @delete
  Future<void> deleteArticle(Article article);
}
