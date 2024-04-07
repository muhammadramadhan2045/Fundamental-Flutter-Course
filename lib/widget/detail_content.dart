import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/common/global.dart' as global;
import 'package:restaurant_app/widget/list_menu.dart';

class DetailContent extends StatelessWidget {
  const DetailContent(
      {super.key, required this.restaurant, required this.allMenu});

  final Restaurantss restaurant;
  final List allMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: restaurant.id ?? '',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              global.imageMedium + (restaurant.pictureId ?? ''),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          restaurant.name ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.place,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                restaurant.city ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          restaurant.description ?? '',
          style: const TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        const Text(
          'Menu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListMenu(allMenu: allMenu),
      ],
    );
  }
}
