import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../domain/models/responses/breaking_news_response.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponse>> getBreakingNews({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('sources') String? category,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });
}
