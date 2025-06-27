import 'package:http/http.dart' as http;

abstract class IHttpClient{
  Future get({required String url});
}
class HttpClient implements IHttpClient{
  final client = http.Client();
  @override
  Future get({required String url}) async{
    print('a url é : ${Uri.parse(url)}');
    return await client.get(Uri.parse(url));
  }

}