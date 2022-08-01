import 'package:dio/dio.dart';
import 'package:todo_app/common/auth_interceptors.dart';

class ApiRepository {
  static Dio? _instance;

  static Dio getInstance() {
    if (_instance == null) {
      _instance = Dio(
        BaseOptions(
          baseUrl: 'https://beta.mrdekk.ru/todobackend',
          contentType: 'application/json',
          connectTimeout: 5000,
          receiveTimeout: 5000,
        ),
      );

      _instance?.interceptors.add(AuthInterceptors());
    }

    return _instance!;
  }
}
