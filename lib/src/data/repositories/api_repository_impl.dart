import '../../core/resources/data_state.dart';
import '../../domain/models/requests/breaking_news_request.dart';
import '../../domain/models/responses/breaking_news_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../datasources/remote/news_api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final NewsApiService _newsApiService;

  ApiRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNews({
    required BreakingNewsRequest request,
  }) async {
    return getStateOf<BreakingNewsResponse>(
      () => _newsApiService.getBreakingNews(
        apiKey: request.apiKey,
        country: request.country,
        page: request.page,
        pageSize: request.pageSize,
      ),
    );
  }
}
