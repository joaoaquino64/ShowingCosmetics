// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'style.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;

  TextEditingController txtSearchCtrl = TextEditingController();

  late String textoProcura = '';
  int selectedIndex = 1;

  // Função chamada quando o texto da SearchBar é alterado
  void onSearchTextChanged() {
    textoProcura = '';
    String searchText = txtSearchCtrl.text;

    textoProcura = searchText;
    setState(() {});
  }

  @override
  void initState() {
    txtSearchCtrl.addListener((onSearchTextChanged));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Bem vindo(a) ao Showing Cosmetics !!!',
            style: dialogTitleStyle,
            textAlign: TextAlign.center,
          ),
          content: Text(textClas),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF43C54D)),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<String> favoriteProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: db.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            var docs = snapshot.data!.docs;

            List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDocs =
                docs
                    .where((doc) => doc['name']
                        .toString()
                        .toLowerCase()
                        .contains((textoProcura).toLowerCase()))
                    .toList();
            docs = filteredDocs;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                header,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  constraints: BoxConstraints(
                    maxHeight: 30,
                  ),
                  child: SearchBar(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFB8ECBC)),
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
                Expanded(
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
                                SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 0, 250, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Propósito:',
                                          style: productPreviewStyle),
                                      Text(doc['purpose'],
                                          style: productPreviewStyle),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    final String productCode = doc['code'];
                                    final String productName = doc['name'];

                                    setState(() {
                                      if (favoriteProducts
                                          .contains(productCode)) {
                                        favoriteProducts.remove(productCode);
                                        FirestoreService().removeFromFavorites(
                                            productName, productCode);
                                      } else {
                                        favoriteProducts.add(productCode);
                                        FirestoreService().addToFavorites(
                                            productName, productCode);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    favoriteProducts.contains(doc['code'])
                                        ? Icons.star
                                        : Icons.star_border,
                                    color:
                                        const Color.fromARGB(255, 79, 255, 59),
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },
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
