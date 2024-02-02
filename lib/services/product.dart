import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  final rooturl = 'http://localhost:3000/api';
  final client = http.Client();
  Future<dynamic> getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await client.get(Uri.parse('$rooturl/products'),
        headers: {"Authorization": "Bearer $token"});

    return json.decode(response.body);
  }
}
