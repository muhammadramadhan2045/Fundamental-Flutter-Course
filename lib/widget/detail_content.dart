import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/common/global.dart' as global;
import 'package:restaurant_app/widget/list_menu.dart';
import 'package:restaurant_app/widget/list_review.dart';
import 'package:restaurant_app/widget/sub_heading_text.dart';

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
        Stack(
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
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    restaurant.city ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.category,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    restaurant.categories?.map((e) => e.name).join(', ') ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
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
        const SubHeadingText(title: 'Menu'),
        const SizedBox(height: 8),
        ListMenu(allMenu: allMenu),
        const SizedBox(height: 16),
        const SubHeadingText(title: 'Reviews'),
        ListReview(restaurant: restaurant)
      ],
    );
  }
}
