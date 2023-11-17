// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'style.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  final db = FirebaseFirestore.instance;
  List<String> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
  }

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
                                    Text('${doc['name']} - ${doc['brand']}',
                                        style: productNameStyle),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Propósito:',
                                        style: productPreviewStyle),
                                    Text(doc['purpose'],
                                        style: productPreviewStyle)
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
                                  color: const Color.fromARGB(255, 79, 255, 59),
                                  size: 30,
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
