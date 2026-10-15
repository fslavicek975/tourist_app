import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_app/di.dart';
import 'package:tourist_app/presentation/core/style/extensions.dart';
import 'package:tourist_app/presentation/sights/widget/sight_card.dart';

import '../notifier/state/sight_list_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sightNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Places', style: context.textTitle),
              switch (state) {
                LoadingState() => Expanded(
                  child: Center(
                    child: Lottie.asset(
                      "assets/animations/loading_sights.json",
                      width: 75,
                    ),
                  ),
                ),
                EmptyState() => Expanded(child: SightListStateWidget.empty()),

                SuccessState(sights: final listOfSights) => Expanded(
                  child: ListView.separated(
                    itemCount: listOfSights.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) =>
                        SightCard(listOfSights[index]),
                  ),
                ),

                ErrorState(message: final erroMessage) => Expanded(
                  child: SightListStateWidget.error(erroMessage),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class SightListStateWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const SightListStateWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  factory SightListStateWidget.empty() => const SightListStateWidget(
    imageUrl: "assets/images/no_locations_found.png",
    title: 'No places found.',
    subtitle: 'Try to refresh the screen or check later.',
  );
  factory SightListStateWidget.error(final errorMessage) =>
      SightListStateWidget(
        imageUrl: "assets/images/error_image.png",
        title: errorMessage,
        subtitle: 'Please try again or check your internet connection',
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(imageUrl, width: 250),
          const SizedBox(height: 20),
          Text(title, style: context.textSubtitle),
          Text(subtitle, style: context.textLabel),
        ],
      ),
    );
  }
}
