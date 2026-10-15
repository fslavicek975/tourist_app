import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/domain/model/sight.dart';
import 'package:tourist_app/presentation/core/style/extensions.dart';
import 'package:tourist_app/presentation/sights/notifier/state/favorites_state.dart' as favorites;
import 'package:tourist_app/presentation/sights/widget/sight_card.dart';

import '../../../di.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Favorites', style: context.textTitle),
              const SizedBox(height: 20),
              Expanded(
                child: switch (state) {
                  favorites.LoadingState() => const Center(child: CircularProgressIndicator()),
                  favorites.EmptyState() => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text("No sights marked as favorites yet."),
                      ],
                    ),
                  ),
                  favorites.SuccessState(sights: final favoriteSights) => ListView.separated(
                    itemCount: favoriteSights.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final local = favoriteSights[index];
                      final sight = Sight(
                        id: local.remoteId ?? 0,
                        title: local.title ?? '',
                        description: local.description ?? '',
                        address: '', 
                        lat: local.lat ?? 0.0,
                        lng: local.lng ?? 0.0,
                        rating: local.ranking ?? 0,
                        imageUrl: local.imageUrl ?? '',
                      );
                      return SightCard(sight);
                    },
                  ),
                  favorites.ErrorState(message: final msg) => Center(child: Text("Error: $msg")),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
