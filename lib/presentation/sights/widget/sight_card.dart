import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/presentation/core/app_router.dart';
import 'package:tourist_app/presentation/core/style/extensions.dart';
import 'package:tourist_app/presentation/sights/notifier/state/favorites_state.dart' as favorites;
import 'package:tourist_app/presentation/sights/widget/rating_stars.dart';

import '../../../di.dart';
import '../../../domain/model/sight.dart';

class SightCard extends ConsumerWidget {
  final Sight sight;

  const SightCard(this.sight, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesNotifierProvider);
    bool isFavorite = false;

    if (favoritesState is favorites.SuccessState) {
      isFavorite = favoritesState.sights.any((s) => s.remoteId == sight.id);
    }

    return GestureDetector(
      onTap: () {
        ref.read(selectedSightProvider.notifier).state = sight;
        Navigator.of(context).pushNamed(AppRouter.sightDetailsScreen);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                sight.imageUrl,
                width: 135,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.title,
                    style: context.textCardTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    sight.address,
                    style: context.textCardSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${sight.lat}, ${sight.lng}',
                    style: context.textCardLabel,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  RatingStars(sight.rating),
                ],
              ),
            ),
            Icon(
              Icons.favorite_rounded,
              color: isFavorite ? Colors.red : Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
