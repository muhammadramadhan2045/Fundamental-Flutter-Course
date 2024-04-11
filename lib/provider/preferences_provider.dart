import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/utils/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurant();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantEnabled = false;
  bool get isDailyRestaurantEnabled => _isDailyRestaurantEnabled;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void setDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void _getDailyRestaurant() async {
    _isDailyRestaurantEnabled =
        await preferencesHelper.isDailyRestaurantEnabled;
    notifyListeners();
  }

  void setDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurant();
  }

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
