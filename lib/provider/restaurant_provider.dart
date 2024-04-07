import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Restaurant _restaurants;
  late ResultState _state;
  String _message = '';

  Restaurant get result => _restaurants;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurants();
      if (restaurant.restaurants?.isEmpty ?? true) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurants = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
