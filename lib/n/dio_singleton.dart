import 'package:dio/dio.dart';


class DioSingleton {
  Dio dio = Dio(BaseOptions(
      headers: {
        'apikey': "09ef3f5fb7bc0d8b2f0779f4f47494bce3cc24f953d59bea0b2c87cafe6707bc",
        'Content-Type': 'application/json'
      }
      ));

  static final DioSingleton _singleton = DioSingleton._internal();

  factory DioSingleton() {

    return _singleton;
  }

  DioSingleton._internal();
}
