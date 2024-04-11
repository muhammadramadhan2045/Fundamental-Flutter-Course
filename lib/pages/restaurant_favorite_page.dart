import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widget/list_restaurant_tile.dart';
import 'package:lottie/lottie.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const String routeName = '/restaurant_favorite_page';
  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (_, provider, __) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                return ListRestaurantTile(
                    restaurants: provider.restaurants[index]);
              },
            );
          } else {
            return Center(
              child: Lottie.asset('assets/empty.json', width: 200, height: 200),
            );
          }
        },
      ),
    );
  }
}
