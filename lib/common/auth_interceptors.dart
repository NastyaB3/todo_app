import 'package:dio/dio.dart';

class AuthInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': 'Bearer Ansginia'});

    handler.next(options);
  }

//todo: onError 2 фаза
}
