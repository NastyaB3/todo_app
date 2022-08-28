import 'package:dio/dio.dart';
import 'package:todo_app/common/error/exception.dart';

class AuthInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': 'Bearer Ansginia'});

    handler.next(options);
  }

  @override
  void onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) {
    var statusCode = err.response!.statusCode!;
    if (statusCode == 400) {
      return handler.reject(BadRequest());
    }

    if (statusCode >= 500 && statusCode <= 599) {
      return handler.reject(ServerInternal());
    }

    if (statusCode == 403) {
      return handler.reject(Forbidden());
    }
    if (statusCode == 401) {
      return handler.reject(Unauthorized());
    }

    if (statusCode == 404) {
      return handler.reject(NotFound());
    }

    if (statusCode > 401 && statusCode <= 499) {
      return handler.reject(UnknownError());
    }
    return handler.next(err);
  }
}
