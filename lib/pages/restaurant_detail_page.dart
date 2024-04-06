import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widget/detail_content.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const String routeName = '/restaurant_detail';

  final Restaurants restaurant;
  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    List allMenu = [
      ...restaurant.menus?.foods ?? [],
      ...restaurant.menus?.drinks ?? []
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? ''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DetailContent(restaurant: restaurant, allMenu: allMenu),
        ),
      ),
    );
  }
}
