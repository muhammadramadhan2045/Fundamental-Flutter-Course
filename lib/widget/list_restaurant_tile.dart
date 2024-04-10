import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/pages/restaurant_detail_page.dart';
import '../common/global.dart' as global;

class ListRestaurantTile extends StatelessWidget {
  const ListRestaurantTile({
    super.key,
    required this.restaurants,
  });

  final Restaurants restaurants;

  @override
  Widget build(BuildContext context) {
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
  }
}
