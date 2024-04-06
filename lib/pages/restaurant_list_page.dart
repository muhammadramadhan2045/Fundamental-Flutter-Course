import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';

class RestaurantListPage extends StatefulWidget {
  static const String routeName = '/restaurant_list';
  const RestaurantListPage({super.key});

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          List<Restaurants> restaurants = parseRestaurants(snapshot.data ?? '');
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Hero(
                        tag: restaurants[index].id ?? '',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            restaurants[index].pictureId ??
                                'https://picsum.photos/200/300',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(restaurants[index].name ?? ''),
                      subtitle: Text(restaurants[index].city ?? ''),
                      onTap: () => Navigator.of(context).pushNamed(
                        RestaurantDetailPage.routeName,
                        arguments: restaurants[index],
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  List<Restaurants> parseRestaurants(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> restaurantList = jsonData['restaurants'] ?? [];
    return restaurantList.map((item) => Restaurants.fromJson(item)).toList();
  }
}
