import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:takemg/consts/baseUrl.dart';
import 'package:takemg/models/login.dart';

class DataRepository {
  Future<List<DataModel>> fetchData(String email) async {
    final response =
        await http.get(Uri.parse('${BaseUrl}read.php?email=$email'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse.map((data) => DataModel.fromJson(data)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

 
  




}
