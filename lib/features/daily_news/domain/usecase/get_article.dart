import 'package:base_core/core/constant/use_case.dart';
import 'package:base_core/core/resources/data_state.dart';
import 'package:base_core/features/daily_news/domain/entities/article.dart';
import 'package:base_core/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {

  final ArticleRepository repo;

  GetArticleUseCase(this.repo);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return repo.getNewsArticle();
  }
}
