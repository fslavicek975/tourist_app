import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:tourist_app/data/client/firebase_auth_client.dart';
import 'package:tourist_app/data/client/sight_rest_client.dart';
import 'package:tourist_app/data/repository/local_sight_repository_impl.dart';
import 'package:tourist_app/data/repository/sight_repository_impl.dart';
import 'package:tourist_app/data/repository/user_repository_impl.dart';
import 'package:tourist_app/domain/repository/local_sight_repository.dart';
import 'package:tourist_app/domain/repository/sight_repository.dart';
import 'package:tourist_app/domain/repository/user_repository.dart';
import 'package:tourist_app/domain/usecase/user_sign_in_use_case.dart';
import 'package:tourist_app/presentation/auth/notifier/authentication_notifier.dart';
import 'package:tourist_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:tourist_app/presentation/sights/notifier/sight_notifier.dart';
import 'package:tourist_app/presentation/sights/notifier/state/sight_list_state.dart';

import 'domain/usecase/get_all_sights_use_case.dart';
import 'domain/usecase/user_sign_up_use_case.dart';
import 'domain/usecase/user_sign_out_use_case.dart';
import 'domain/usecase/toggle_favorite_use_case.dart';
import 'domain/usecase/get_favorite_sights_use_case.dart';

import 'package:tourist_app/presentation/sights/notifier/favorites_notifier.dart';
import 'package:tourist_app/presentation/sights/notifier/state/favorites_state.dart';
import 'package:tourist_app/presentation/sights/notifier/sight_details_notifier.dart';
import 'package:tourist_app/presentation/sights/notifier/state/sight_details_state.dart';
import 'package:tourist_app/domain/model/sight.dart';

// ************** DATABASE **************//
final isarProvider = Provider<Isar>((ref) => throw UnimplementedError());

// ************** CLIENT **************//
final firebaseAuthClientProvider = Provider<FirebaseAuthClient>((_) => FirebaseAuthClient());

final dioProvider = Provider<Dio>((_) => Dio());
final sightRestClientProvider = Provider<SightRestClient>((ref) => SightRestClient(ref.watch(dioProvider)));

// ************** REPOSITORY **************//
final userRepositoryProvider = Provider<UserRepository>(
        (ref) => UserRepositoryImpl(ref.watch(firebaseAuthClientProvider))
);

final sightRepositoryProvider = Provider<SightRepository>(
        (ref) => SightRepositoryImpl(ref.watch(sightRestClientProvider)));

final localSightRepositoryProvider = Provider<LocalSightRepository>(
        (ref) => LocalSightRepositoryImpl(ref.watch(isarProvider)));

final selectedSightProvider = StateProvider<Sight?>((ref) => null);


// ************** USE CASE **************//
final userSignInUseCaseProvider = Provider<UserSignInUseCase>(
    (ref) => UserSignInUseCase(ref.watch(userRepositoryProvider))
);

final userSignUpUseCaseProvider = Provider<UserSignUpUseCase>(
    (ref) => UserSignUpUseCase(ref.watch(userRepositoryProvider))
);

final userSignOutUseCaseProvider = Provider<UserSignOutUseCase>(
    (ref) => UserSignOutUseCase(ref.watch(userRepositoryProvider))
);

final getAllSightsUseCaseProvider = Provider<GetAllSightsUseCase>(
        (ref) => GetAllSightsUseCase(ref.watch(sightRepositoryProvider))
);

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>(
    (ref) => ToggleFavoriteUseCase(ref.watch(localSightRepositoryProvider))
);

final getFavoriteSightsUseCaseProvider = Provider<GetFavoriteSightsUseCase>(
    (ref) => GetFavoriteSightsUseCase(ref.watch(localSightRepositoryProvider))
);

// ************** NOTIFIER **************//
final authenticationNotifierProvider = NotifierProvider<AuthenticationNotifier, AuthenticationState>(
    () => AuthenticationNotifier(),
);

final sightNotifierProvider = NotifierProvider<SightNotifier, SightListState>(
      () => SightNotifier(),
);

final favoritesNotifierProvider = NotifierProvider<FavoritesNotifier, FavoritesState>(
      () => FavoritesNotifier(),
);

final sightDetailsNotifierProvider = NotifierProvider<SightDetailsNotifier, SightDetailsState>(
      () => SightDetailsNotifier(),
);
