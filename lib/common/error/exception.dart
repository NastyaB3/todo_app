import 'package:dio/dio.dart';

class NetworkException extends DioError {
  NetworkException() : super(requestOptions: RequestOptions(path: ''));
}

class BadRequest extends NetworkException {}

class NotFound extends UnknownError {}

class ServerInternal extends NetworkException {}

class Forbidden extends NetworkException {}

class UnknownError extends NetworkException {}
