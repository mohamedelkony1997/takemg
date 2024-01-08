
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:takemg/consts/baseUrl.dart';
import 'package:takemg/models/login.dart';
class CrudRepositery {
  Future<void> deleteItem(String email, int id) async {
    try {
      final response = await http.get(
        Uri.parse('${BaseUrl}delete.php?email=$email&id=$id'),
      );

      if (response.statusCode == 200) {
        print('Item deleted successfully');
      } else {
        print('Failed to delete item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while deleting item: $e');
    }
  }

  Future<void> editItem(String email, int id, String title, String description,
      String imgLink) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${BaseUrl}edit.php?email=$email&id=$id&title=$title&description=$description&img_link=$imgLink'),
      );

      if (response.statusCode == 200) {
        print('Item edited successfully');
      } else {
        print('Failed to edit item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while editing item: $e');
    }
  }

  Future<void> addItem(
      String title, String description, String imgLink, String email) async {
    try {
      final response = await http.post(
        Uri.parse('${BaseUrl}create.php'),
        body: jsonEncode({
          "title": title,
          "description": description,
          "img_link": imgLink,
          "email": email,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Item added successfully');
      } else {
        print('Failed to add item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while adding item: $e');
    }
  }
}
