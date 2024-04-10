import 'package:flutter/material.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/data/result_state.dart';
import 'package:news_app/utils/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DatabaseProvider({required this.databaseHelper}) {
    _getBookmarks();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Articles> _bookmarks = [];
  List<Articles> get bookmarks => _bookmarks;

  void _getBookmarks() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isEmpty) {
      _state = ResultState.noData;
      _message = 'Empty Data';
      notifyListeners();
    } else {
      _state = ResultState.hasData;
      notifyListeners();
    }
  }

  void addBookmark(Articles article) async {
    try {
      await databaseHelper.insertBookmark(article);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarkedArticle = await databaseHelper.getBookMarkByUrl(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeBookmark(String url) async {
    try {
      await databaseHelper.removeBookmark(url);
      _getBookmarks();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }
}
