import 'package:dio/dio.dart';
import 'package:boiler_plate_1/api_client/api_errors/internal_server_api_error.dart';

class InternalServerErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError error) async {
    if (error.response != null) {
      if (error.response.statusCode >= 500 && error.response.statusCode < 600) {
        return InternalServerApiError();
      }
    }

    return null;
  }
}