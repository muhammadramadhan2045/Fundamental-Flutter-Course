import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final String id;
  DetailRestaurantProvider({required this.id}) {
    _getDetailRestaurant(id);
  }

  late ResaturantDetail _restaurant;
  late ResultState _state;
  String _message = '';

  ResaturantDetail get result => _restaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await ApiService().getDetailRestaurant(id);
      if (detailRestaurant.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurant = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = '$e';
      notifyListeners();
    }
  }
}
