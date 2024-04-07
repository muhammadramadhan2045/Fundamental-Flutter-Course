import 'package:restaurant_app/data/model/restaurant.dart';

class SearchRestaurant {
  bool? error;
  int? founded;
  List<Restaurants>? restaurants;

  SearchRestaurant({this.error, this.founded, this.restaurants});

  SearchRestaurant.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    founded = json['founded'];
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['founded'] = founded;
    if (restaurants != null) {
      data['restaurants'] = restaurants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
