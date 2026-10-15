import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int maxRating;
  final int rating;

  const RatingStars(this.rating, {super.key, this.maxRating = 5});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 25,
      child: Row(
        children: [
          ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber, size: 25),
            separatorBuilder: (_, __) => const SizedBox(width: 2),
            itemCount: rating,
            shrinkWrap: true,
          ),
          ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.grey, size: 25),
            separatorBuilder: (_, __) => const SizedBox(width: 2),
            itemCount: maxRating - rating,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
