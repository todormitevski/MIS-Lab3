import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';
import 'screens/jokes_by_type_screen.dart';
import 'screens/random_joke_screen.dart';
import 'screens/favorites_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // firebase cloud messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  String? token = await messaging.getToken();
  print("FCM Registration Token: $token");
  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: const MyApp(),
    ),
  );
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  // Handle background message
  print("Handling background message: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joker',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jokesByType': (context) {
          final type = ModalRoute.of(context)!.settings.arguments as String;
          return JokesByTypeScreen(type: type);
        },
        '/randomJoke': (context) => const RandomJokeScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}
