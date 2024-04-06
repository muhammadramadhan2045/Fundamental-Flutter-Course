import 'dart:convert';

import 'package:news_app/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = 'd2db5ed32016446d9aef7d547c806dbe';
  static const String _sources = 'techcrunch';

  Future<Article> getArticles() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?sources=$_sources&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return Article.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
