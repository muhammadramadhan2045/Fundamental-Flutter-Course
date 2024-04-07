import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/pages/restaurant_search_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../widget/list_restaurant_tile.dart';

class RestaurantListPage extends StatelessWidget {
  static const String routeName = '/restaurant_list';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed(RestaurantSearchPage.routeName);
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            if (state.state == ResultState.hasData) {
              final List<Restaurants> restaurants =
                  state.result.restaurants ?? [];
              return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return ListRestaurantTile(restaurants: restaurants[index]);
                },
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(height: 8),
                    Text(state.message),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No Data'),
              );
            }
          }
        },
      ),
    );
  }
}
