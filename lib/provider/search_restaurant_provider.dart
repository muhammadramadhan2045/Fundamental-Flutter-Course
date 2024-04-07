import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  String _query = '';
  SearchRestaurant? _restaurants; // Menggunakan tipe nullable
  ResultState? _state; // Menggunakan tipe nullable
  String _message = '';
  TextEditingController searchController = TextEditingController();

  SearchRestaurant get result => _restaurants ?? SearchRestaurant();
  ResultState get state => _state ?? ResultState.loading;
  String get message => _message;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await ApiService().searchRestaurants(query);
      if (searchRestaurant.restaurants?.isEmpty ?? true) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurants = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  String get query => _query;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }
}
