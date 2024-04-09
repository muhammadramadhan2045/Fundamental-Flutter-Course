import 'package:flutter/material.dart';
import 'package:news_app/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyNews();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyNewsEnabled = false;
  bool get isDailyNewsEnabled => _isDailyNewsEnabled;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyNews() async {
    _isDailyNewsEnabled = await preferencesHelper.isDailyNewsEnabled;
    notifyListeners();
  }

  void setDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void setDailyNews(bool value) {
    preferencesHelper.setDailyNews(value);
    _getDailyNews();
  }

  ThemeData get themeData =>
      _isDarkTheme ? ThemeData.dark() : ThemeData.light();
}
