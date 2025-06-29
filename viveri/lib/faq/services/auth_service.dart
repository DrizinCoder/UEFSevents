import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://localhost:8000/api';

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/token/');
    final response = await http.post(
      url,
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storage.write(key: 'access', value: data['access']);
      await _storage.write(key: 'refresh', value: data['refresh']);
      return true;
    }

    return false;
  }

  Future<String?> getToken() async => await _storage.read(key: 'access');
}