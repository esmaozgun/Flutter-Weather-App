import 'package:http/http.dart' as http;

class HttpService {
  Future<http.Response> getRequest(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
