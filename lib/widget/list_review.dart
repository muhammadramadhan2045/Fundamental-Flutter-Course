import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

class ListReview extends StatelessWidget {
  const ListReview({
    super.key,
    required this.restaurant,
  });

  final Restaurantss restaurant;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurant.customerReviews?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final review = restaurant.customerReviews?[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  review?.name ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              review?.review ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
