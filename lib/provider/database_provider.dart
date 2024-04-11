import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _restaurants = [];
  List<Restaurants> get restaurants => _restaurants;

  void _getFavorites() async {
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.isEmpty) {
      _state = ResultState.noData;
      _message = 'Empty data';
    } else {
      _state = ResultState.hasData;
    }
    notifyListeners();
  }

  void addFavorites(dynamic restaurants) async {
    try {
      await databaseHelper.insertFavorite(restaurants);
      debugPrint('Add Favorite Success');
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }

  void removeFavorites(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      debugPrint('Remove Favorite Success');
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }
}
