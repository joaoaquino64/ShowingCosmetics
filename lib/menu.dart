// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class MenuPage extends StatefulWidget {
  MenuPage({super.key});
  final db = FirebaseFirestore.instance;

  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final db = FirebaseFirestore.instance;
  int selectedIndex = 0;
  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header,
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 140),
              child: Text(
                'Categorias',
                style: titleStyle,
              ),
            ),
            SizedBox(height: 60),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db.collection('products').orderBy('form').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                var docs = snapshot.data!.docs;

                return Expanded(
                  child: ListView(
                    children: docs
                        .map(
                          (doc) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Color(0xFF43C54D),
                                height: 1,
                              ),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      doc['form'],
                                      style: categoryStyle,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('/category',
                                                arguments: doc['form']),
                                        child: Image.asset(
                                            'images/arrow_forward.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        )
                        .toList(),
                  ),
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
            }
          });
        },
      ),
    );
  }
}
