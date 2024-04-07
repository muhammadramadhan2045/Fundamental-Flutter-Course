import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/result_state.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/common/global.dart' as global;

class RestaurantListPage extends StatelessWidget {
  static const String routeName = '/restaurant_list';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        centerTitle: true,
        elevation: 0,
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
                  return ListTile(
                    leading: Hero(
                      tag: restaurants[index].id ?? '',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          global.imageSmall +
                              (restaurants[index].pictureId ?? ''),
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
                      arguments: restaurants[index].id ?? '',
                    ),
                  );
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
