// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final String form = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 140),
              child: Text(form, style: titleStyle),
            ),
            SizedBox(width: double.infinity, height: 50),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db
                  .collection('products')
                  .orderBy('class', descending: true)
                  .where('form', isEqualTo: form)
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Class ${doc['class']}',
                                            style: productClassStyle)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
