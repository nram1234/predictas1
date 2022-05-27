import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../networking/region_json.dart';

Future<dynamic> fetchList() async {
  final response = await http
      .get(Uri.parse('https://lecoinoccasion.fr/api/v1/simple/cities')).then((value){
print("iiiiiiiiii");
  });

// //  if (response.statusCode == 200) {
//     If the server did return a 200 OK response,
//         then parse the JSON.
//   return LocationJson.fromJson(jsonDecode(response.body));
//   } else {
//   // If the server did not return a 200 OK response,
//   // then throw an exception.
//   //throw Exception('Failed to load album');
//   //}
}




