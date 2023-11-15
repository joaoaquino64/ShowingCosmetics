// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final db = FirebaseFirestore.instance;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  final txtSearchCtrl = TextEditingController();
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              constraints: BoxConstraints(
                maxHeight: 30,
              ),
              child: SearchBar(
                backgroundColor: MaterialStateProperty.all(Color(0xFFB8ECBC)),
                leading: Icon(Icons.search),
                hintText: 'Procurar produto',
                hintStyle: MaterialStateProperty.all(
                  TextStyle(color: Colors.grey.withOpacity(0.5)),
                ),
                controller: txtSearchCtrl,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db
                  .collection('products')
                  .orderBy('class', descending: true)
                  // .where('name'.toLowerCase() == txtSearchCtrl.toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                var docs = snapshot.data!.docs;

                return Expanded(
                  child: ListView(
                    children: docs
                        .map(
                          (doc) => GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed('/product', arguments: doc['code']),
                            child: Column(
                              children: [
                                Container(
                                  color: Color(0xFF43C54D),
                                  height: 1,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 20, 50, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(doc['form'],
                                              style: productFormStyle)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('Class ${doc['class']}',
                                              style: productClassStyle)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 21),
                                  color: Color(0xFF43C54D),
                                  height: 1,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset('images/check.png'),
                                      Text(
                                        '${doc['name']} - ${doc['brand']}',
                                        style: productNameStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  color: Color(0xFF43C54D),
                                  height: 1,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Propósito:',
                                      style: productPreviewStyle,
                                    ),
                                    Text(
                                      doc['purpose'],
                                      style: productPreviewStyle,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10)
                              ],
                            ),
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
            //else if (index == 2) {
            //   Navigator.of(context).pushNamed('/add');
            // }
          });
        },
      ),
    );
  }
}
