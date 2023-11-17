// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class MenuPage extends StatefulWidget {
  MenuPage({super.key});

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final db = FirebaseFirestore.instance;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header,
            SizedBox(height: 40, width: double.infinity),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 140),
              child: Text('Categorias', style: titleStyle),
            ),
            SizedBox(height: 60, width: double.infinity),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db.collection('products').orderBy('form').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                var docs = snapshot.data!.docs;

                List<String> filtro = [];
                List<QueryDocumentSnapshot<Map<String, dynamic>>> docsFiltrado =
                    [];
                docs.forEach((doc) {
                  var formValue = doc['form'] as String?;
                  if (formValue != null && !filtro.contains(formValue)) {
                    filtro.add(formValue);
                    docsFiltrado.add(doc);
                  }
                });

                docs = docsFiltrado;

                if (docs.isEmpty) {
                  return const Center(
                    child: Text('Nada disponível.'),
                  );
                }
                return Expanded(
                  child: ListView(
                      children: docsFiltrado
                          .map((doc) => Category(doc['form']))
                          .toList()),
                );
              },
            )
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
}
