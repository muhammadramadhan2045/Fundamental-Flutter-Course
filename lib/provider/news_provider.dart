import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/result_state.dart'; 

import '../data/model/article.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    getArticles();
  }

  late Article _article;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Article get result => _article;

  ResultState get state => _state;

  Future<dynamic> getArticles() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final articles = await apiService.getArticles();
      if (articles.articles?.isEmpty ?? true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _article = articles;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
