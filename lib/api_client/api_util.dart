import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
import 'package:boiler_plate_1/api_client/api_errors/api_error_message_error.dart';
import 'package:boiler_plate_1/api_client/api_errors/bad_network_api_error.dart';
import 'package:boiler_plate_1/api_client/api_errors/internal_server_api_error.dart';
import 'package:boiler_plate_1/api_client/api_errors/unauthorized_api_error.dart';
import 'package:boiler_plate_1/api_client/interceptors/api_error_message_interceptor.dart';
import 'package:boiler_plate_1/api_client/interceptors/auth_interceptor.dart';
import 'package:boiler_plate_1/api_client/interceptors/bad_network_error_interceptor.dart';
import 'package:boiler_plate_1/api_client/interceptors/internal_server_error_interceptor.dart';
import 'package:boiler_plate_1/api_client/interceptors/unauthorized_interceptor.dart';
import 'package:boiler_plate_1/api_client/exceptions/exceptions.dart';
// import 'package:shared_preference/constants/env.dart';
// import 'package:shared_preference/pretty_dio_logger.dart';

// @lazySingleton
class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options.baseUrl = "https://pokeapi.co/api/v2/pokemon";//url
    dio.options.connectTimeout = const Duration(minutes: 3).inMilliseconds;
    dio.options.receiveTimeout = const Duration(minutes: 3).inMilliseconds;
    // dio.interceptors.add(BadNetworkErrorInterceptor());
    dio.interceptors.add(InternalServerErrorInterceptor());
    // dio.interceptors.add(AuthInterceptor());
    dio.interceptors.add(UnauthorizedInterceptor());
    dio.interceptors.add(ApiErrorMessageInterceptor());

    // if (Env.data.debugApiClient) {
    //   dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     error: true,
    //     compact: true,
    //   ));
    // }
  }

  Future<Response> post(
      String path,
      dynamic data,
      ) async {
    try {
      return await dio.post(path, data: data);
    } on BadNetworkApiError {
      throw BadNetworkException();
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data);
    } on BadNetworkApiError {
      throw BadNetworkException();
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } on BadNetworkApiError {
      throw BadNetworkException();
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage);
    } on DioError {
      throw ApiException();
    }
  }

  Future<Response> get(String path) async {
    try {
      return await dio.get(path);
    } on BadNetworkApiError {
      throw BadNetworkException();
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage);
    } on DioError {
      throw ApiException();
    }
  }
}