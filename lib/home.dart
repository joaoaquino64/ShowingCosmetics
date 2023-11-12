// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final db = FirebaseFirestore.instance;
  // int selectedOption = 1;

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
                                  margin: EdgeInsets.fromLTRB(51, 0, 15, 0),
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
                                  margin: EdgeInsets.symmetric(horizontal: 53),
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
      bottomNavigationBar: navBar,
    );
  }
}
