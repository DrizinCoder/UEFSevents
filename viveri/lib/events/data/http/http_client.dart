import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
  Future post({
    required String url,
    required String body,
    required Map<String, String> headers,
  });
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  @override
  Future get({required String url}) async {
    print('a url é : ${Uri.parse(url)}');
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
}
