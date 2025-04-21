import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticleService {
  static const String _apiKey = '2db94ea87f8948289aeb696c66536c53';
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  static Future<List<dynamic>> fetchSleepArticles() async {
    final url = Uri.parse('$_baseUrl?q=sleep&language=en&sortBy=publishedAt&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Gagal ambil artikel');
    }
  }
}
