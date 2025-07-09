import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
  Future post({
    required String url,
    required String body,
    required Map<String, String> headers,
  });
  Future<dynamic> delete({
    required String url,
    required String body,
    required Map<String, String> headers,
  });
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }

  @override
  Future post({
    required String url,
    required String body,
    required Map<String, String> headers,
  }) async {
    return await client.post(Uri.parse(url), body: body, headers: headers);
  }


  @override
  Future delete({required String url, required String body, required Map<String, String> headers}) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}
