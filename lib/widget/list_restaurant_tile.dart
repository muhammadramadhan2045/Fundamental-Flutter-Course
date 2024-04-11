import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import '../common/global.dart' as global;

class ListRestaurantTile extends StatelessWidget {
  const ListRestaurantTile({
    super.key,
    required this.restaurants,
  });

  final Restaurants restaurants;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorite(restaurants.id ?? ''),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return ListTile(
              leading: Hero(
                tag: restaurants.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    global.imageSmall + (restaurants.pictureId ?? ''),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(restaurants.name ?? ''),
              subtitle: Text(restaurants.city ?? ''),
              trailing: isFavorite
                  ? IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        provider.removeFavorites(restaurants.id ?? '');
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        provider.addFavorites(restaurants);
                      },
                    ),
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   RestaurantDetailPage.routeName,
                //   arguments: restaurants.id ?? '',
                // );

                Navigation.intentWithData(
                  RestaurantDetailPage.routeName,
                  restaurants.id ?? '',
                );
              },
            );
          });
    });
  }
}
