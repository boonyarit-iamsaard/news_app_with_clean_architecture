import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/resources/data_state.dart';

abstract class BaseApiRepository {
  /// This method is responsible of handling the given `request`, in which
  /// it returns generic based `DataState`.
  ///
  /// Returns `DataSuccess` that holds the generic data `T` if the response
  /// is successfully received.
  ///
  /// Returns `DataFailed` that holds a `DioError` instance if any error occurs
  /// while sending the request or receiving the response.
  @protected
  Future<DataState<T>> getStateOf<T>(
      Future<HttpResponse<T>> Function() request) async {
    try {
      final httpResponse = await request();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    } catch (e) {
      return DataError(
        DioException(
          error: 'Unknown error',
          requestOptions: RequestOptions(),
        ),
      );
    }
  }
}
