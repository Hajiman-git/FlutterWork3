import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String apiKey;

  AuthInterceptor({required this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Api-Key'] = apiKey;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {

    }
    super.onError(err, handler);
  }
}