import '../../core/resources/data_state.dart';
import '../models/requests/breaking_news_request.dart';
import '../models/responses/breaking_news_response.dart';

abstract class ApiRepository {
  Future<DataState<BreakingNewsResponse>> getBreakingNews({
    required BreakingNewsRequest request,
  });
}
