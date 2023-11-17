import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:showing_cosmetics/category.dart';
import 'package:showing_cosmetics/favorite.dart';
import 'package:showing_cosmetics/home.dart';
import 'package:showing_cosmetics/menu.dart';
import 'package:showing_cosmetics/product.dart';

const FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyDqaJjcE5KUlGqsLPRK_HiSOxz6XfhTb0I",
    authDomain: "showing-cosmetics-att.firebaseapp.com",
    projectId: "showing-cosmetics-att",
    storageBucket: "showing-cosmetics-att.appspot.com",
    messagingSenderId: "458294898331",
    appId: "1:458294898331:web:754d921c4bdda79cde603e",
    measurementId: "G-JK6HNYYPFP");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => HomePage(),
        '/product': (context) => ProductPage(),
        '/menu': (context) => MenuPage(),
        '/category': (context) => CategoryPage(),
        '/favorite': (context) => FavoritePage(),
      },
      initialRoute: '/home',
    );
  }
}
