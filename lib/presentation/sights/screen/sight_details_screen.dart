import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart' as auth;
import 'package:tourist_app/presentation/core/style/extensions.dart';
import 'package:tourist_app/presentation/sights/notifier/state/sight_details_state.dart' as details;
import '../../../di.dart';

class SightDetailsScreen extends ConsumerWidget {
  const SightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sight = ref.watch(selectedSightProvider);
    final detailsState = ref.watch(sightDetailsNotifierProvider);

    if (sight == null) {
      return const Scaffold(body: Center(child: Text("No sight selected")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(sight.title),
        actions: [
          if (detailsState is details.SuccessState)
            IconButton(
              icon: Icon(
                detailsState.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: detailsState.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                ref.read(sightDetailsNotifierProvider.notifier).toggleFavorite();
              },
            ),
        ],
      ),
      body: switch (detailsState) {
        details.LoadingState() => const Center(child: CircularProgressIndicator()),
        details.ErrorState(message: final msg) => Center(child: Text(msg)),
        details.SuccessState(isFavorite: final _, ranking: final ranking) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                sight.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sight.title, style: context.textTitle),
                    const SizedBox(height: 8),
                    Text(sight.description, style: context.textSubtitle),
                    const SizedBox(height: 20),
                    const Text("Ranking:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < (ranking ?? 0) ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          onPressed: () {
                            ref.read(sightDetailsNotifierProvider.notifier).updateRanking(index + 1);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      },
    );
  }
}
