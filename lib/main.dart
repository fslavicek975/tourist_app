
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tourist_app/di.dart';
import 'package:tourist_app/domain/model/sight_local.dart';
import 'package:tourist_app/presentation/core/style/app_theme.dart';
import 'package:tourist_app/presentation/core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SightLocalSchema],
    directory: dir.path,
  );

  runApp(ProviderScope(
    overrides: [
      isarProvider.overrideWithValue(isar),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}



