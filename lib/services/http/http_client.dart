import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:panda/app/config.dart';
import 'package:panda/models/typedefs.dart';

/// HttpClient that uses Dio to handle network requests.
///  Usually I would use Fresh to handle token changes.
@Singleton(scope: 'auth')
class HttpClient {
  late final Dio _dio;

  HttpClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.appHttpClientUrl,
      ),
    );
  }

  Future<Response<T>> get<T>(
    String url, {
    JsonMap? queryParameters,
    Options? options,
  }) {
    return _dio.get<T>(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    JsonMap? queryParameters,
    Options? options,
  }) {
    return _dio.post<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    JsonMap? queryParameters,
    Options? options,
  }) {
    return _dio.put<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    JsonMap? queryParameters,
    Options? options,
  }) {
    return _dio.patch<T>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    JsonMap? queryParameters,
    Options? options,
  }) {
    return _dio.delete<T>(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
