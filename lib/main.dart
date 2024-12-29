import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab3_mis/providers/joke_provider.dart';
import 'package:lab3_mis/screens/favorites.dart';
import 'package:lab3_mis/screens/random_joke.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//TODO: за потсетување на корисникот да ја отвори апликацијата и да ја види шегата на денот (во време по ваш избор).

Future<void> main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // Initialize Firebase Cloud Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications (important for iOS)
  await messaging.requestPermission();

  // Retrieve and log the FCM registration token
  String? token = await messaging.getToken();
  print("FCM Registration Token: $token");

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(const MyApp());
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  // Handle background message
  print("Handling background message: ${message.notification?.title}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Display notification when app is in foreground
      if (message.notification != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(message.notification?.title ?? 'No Title'),
            content: Text(message.notification?.body ?? 'No Body'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => JokeProvider()..loadFavorites(), // Автоматско вчитување на омилени шеги
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jokes App',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.blueGrey[200],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
          cardColor: Colors.white,
        ),
        home: HomePage(),
      ),
    );
  }
}



AppBar buildStandardAppBar(BuildContext context, {required String title}) {
  return AppBar(
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.casino),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RandomJokePage()),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
      ),
    ],
  );
}
