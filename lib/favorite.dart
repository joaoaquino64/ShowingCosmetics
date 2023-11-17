// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'style.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final db = FirebaseFirestore.instance;
  int selectedIndex = 2;
  List<String> favoriteProducts =
      []; // Adicione essa lista para armazenar os produtos favoritos

  @override
  void initState() {
    super.initState();
    loadFavorites(); // Carregue a lista de produtos favoritos ao iniciar a página
  }

  void loadFavorites() async {
    List<String> favorites = await FirestoreService().getFavoriteProducts();
    setState(() {
      favoriteProducts = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: favoriteProducts.isEmpty
          ? SafeArea(
              child: Column(
                children: [
                  header,
                  SizedBox(width: double.infinity, height: 50),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: AlignmentDirectional.topStart,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        child: Image.asset('images/arrow_back.png'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  SizedBox(width: double.infinity, height: 50),
                  Center(child: Text('Nenhum produto favorito.'))
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  header,
                  SizedBox(height: 40, width: double.infinity),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: Text('Coleção dos Favoritos', style: titleStyle),
                  ),
                  SizedBox(height: 60, width: double.infinity),
                  // Falta ListView() favoritos :/
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Color(0xFFB8ECBC), size: 30),
        selectedItemColor: Color(0xFFB8ECBC),
        iconSize: 20,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          )
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;

            if (index == 0) {
              Navigator.of(context).pushNamed('/menu');
            } else if (index == 1) {
              Navigator.of(context).pushNamed('/home');
            } else if (index == 2) {
              Navigator.of(context).pushNamed('/favorite');
            }
          });
        },
      ),
    );
  }

  void removeFromFavorites(String productCode) {
    FirestoreService().removeFromFavorites(productCode);
    setState(() {
      favoriteProducts.remove(productCode);
    });
  }
}
