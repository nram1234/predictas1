import 'dart:convert';
import 'package:flutter/material.dart';

import '../Settings/dio.dart';
import 'package:predictas1/networking/AbstractJson.dart';

abstract class ApiManager {
  final DioSingleton dioSingleton = DioSingleton();

  /// Returns the API URL of current API ressource
  String apiUrl();

  // Headers responseHeaders;

  AbstractJsonResource fromJson(data);

  Future<dynamic> getList({Map<String, dynamic>? filters}) async {
    AbstractJsonResource jsonList;
    var data;

    await dioSingleton.dio
        .get(apiUrl(), queryParameters: filters)
        .then((value) {
      data = value.data;
    });
    jsonList = fromJson(data);

    return jsonList;
  }
}
