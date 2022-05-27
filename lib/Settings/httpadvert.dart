import 'dart:convert';

import '../networking/Advert_json.dart';
import 'package:predictas1/networking/Advert_json.dart';
import 'package:http/http.dart' as http;
Future<AdvertsJson?> fetchList() async {
  AdvertsJson advertsJson;
  //var http;
  final response = await http
      .get(Uri.parse('https://lecoinoccasion.fr/api/v1/adverts?categoryGroup=6'));
print(response.body);
  if (response.statusCode == 200) {

    advertsJson= AdvertsJson.fromJson(jsonDecode(response.body));
    return advertsJson;
    // If the server did return a 200 OK response,
    // then parse the JSON.
  //  return AdvertsJson.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}