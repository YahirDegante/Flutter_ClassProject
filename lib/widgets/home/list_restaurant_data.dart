import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:learning_2_10c/modules/home/entities/restaurant.dart';
import 'package:learning_2_10c/modules/home/screens/restaurant_details.dart';

class ListRestaurantData extends StatelessWidget {
  final Restaurant restaurant;

  const ListRestaurantData({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RestaurantDetails(restaurant: restaurant);
        }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            restaurant.imagenes[0],
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Text(
                    restaurant.description,
                  ),
                ),
              ],
            ),
          ),
          StarRating(
            rating: restaurant.rating,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
