import 'package:firebase_core/firebase_core.dart';
import 'package:learning_2_10c/modules/auth/register.dart';
import 'package:learning_2_10c/modules/home/screens/restaurant_details.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:learning_2_10c/modules/auth/login.dart';
import 'package:learning_2_10c/navigation/home.dart';
import 'package:learning_2_10c/navigation/navigation.dart';
import 'package:learning_2_10c/navigation/profile.dart';
import 'package:learning_2_10c/navigation/reservations.dart';
import 'package:learning_2_10c/navigation/top.dart';
import 'package:learning_2_10c/widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/menu': (context) => const Navigation(),
        '/home': (context) => const Home(),
        '/top': (context) => const Top(),
        '/reservations': (context) => const Reservations(),
        '/profile': (context) => const Profile(),
        '/restaurant-details': (context) => RestaurantDetails(),
      },
    );
  }
}
