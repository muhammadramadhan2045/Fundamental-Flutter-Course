import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<Restaurant> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/list'));
      if (response.statusCode == 200) {
        return Restaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load list');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection');
      } else {
        throw Exception('Failed to load list');
      }
    }
  }

  Future<ResaturantDetail> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
      if (response.statusCode == 200) {
        return ResaturantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection');
      } else {
        throw Exception('Failed to load detail');
      }
    }
  }

  Future<SearchRestaurant> searchRestaurants(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
      if (response.statusCode == 200) {
        return SearchRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to search restaurant');
      }
    } catch (e) {
      if (e is SocketException) {
        throw Exception('No Internet Connection');
      } else {
        throw Exception('Failed to search restaurant');
      }
    }
  }
}
