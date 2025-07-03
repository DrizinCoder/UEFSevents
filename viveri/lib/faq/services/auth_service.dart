import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final String _baseUrl =
      'http://192.168.0.117:8000/api'; // 'http://localhost:8000/api';

  Future<bool> login(String username, String password) async {
    try {
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
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: 'access');
    if (token != null && !(await _isTokenExpired(token))) {
      return token;
    }
    return await _refreshToken();
  }

  Future<bool> _isTokenExpired(String token) async {
    try {
      // Divide o JWT em partes (header.payload.signature)
      final parts = token.split('.');
      if (parts.length != 3) return true;
      final payload = parts[1];
      final normalizedPayload = base64.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadMap = json.decode(decodedPayload) as Map<String, dynamic>;

      // Obtém o timestamp de expiração (em segundos)
      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true; // Token não tem data de expiração

      // Converte para DateTime
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);

      // Verifica se o token está expirado
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      // Se ocorrer qualquer erro, considera como expirado
      return true;
    }
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh');
    if (refreshToken == null) return null;

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/token/refresh/'),
        body: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = jsonDecode(response.body)['access'];
        await _storage.write(key: 'access', value: newToken);
        return newToken;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'access');
    await _storage.delete(key: 'refresh');
  }
}
