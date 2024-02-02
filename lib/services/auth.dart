import 'dart:convert';
import 'package:http/http.dart' as http;

class Authentication {
  final rooturl = 'http://localhost:3000/api';
  final client = http.Client();
  Future<dynamic> signUp(name, email, password) async {
    final url = Uri.parse('$rooturl/auth/signup');
    // print(name + email + password);
    final body = {"name": name, "email": email, "password": password};
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      // print('Request failed with status: ${response.body}');
      return null;
    } catch (e) {
      // print('Error during sign-up request: $e');
      return null;
    } finally {
      client.close();
    }
  }

  Future<dynamic> signIn(email, password) async {
    final url = Uri.parse('$rooturl/auth/login');
    final body = {"email": email, "password": password};
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 400) {
        return jsonDecode(response.body);
      }
      if (response.statusCode == 404) {
        return jsonDecode(response.body);
      }
      // print('Request failed with status: ${jsonDecode(response.body)}');
      return null;
    } catch (e) {
      // print('Error during sign-up request: $e');
      return null;
    } finally {
      client.close();
    }
  }
}
