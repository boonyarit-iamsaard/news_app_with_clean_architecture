import '../../../core/utils/constants/constants.dart';

class BreakingNewsRequest {
  final String apiKey;
  final String country;
  final int page;
  final int pageSize;

  const BreakingNewsRequest({
    this.apiKey = defaultApiKey,
    this.country = defaultCountry,
    this.page = 1,
    this.pageSize = defaultPageSize,
  });
}
