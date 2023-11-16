// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final String code = ModalRoute.of(context)?.settings.arguments as String;
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: db
                  .collection('products')
                  .where('code', isEqualTo: code)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                var docs = snapshot.data!.docs;

                return Expanded(
                  child: ListView(
                    children: docs
                        .map(
                          (doc) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 56),
                                child: Column(
                                  children: [
                                    Text(
                                      doc['name'],
                                      style: productDetailNameStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      width: double.infinity,
                                    ),
                                    Container(
                                      color: Color(0xFF43C54D),
                                      height: 1,
                                    ),
                                    SizedBox(
                                      height: 15,
                                      width: double.infinity,
                                    ),
                                    Text(
                                      'Class ${doc['class']}',
                                      style: productDetailClassStyle,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Propósito:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['purpose'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Ingredientes:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['ingredients'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Marca:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['brand'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Forma física do produto:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['form'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Grupo:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['group'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Fabricante:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['manufacturer'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Embalagem:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          doc['packaging'],
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                        ),
                                        Text(
                                          'Validade:',
                                          style: productDetailFieldStyle,
                                        ),
                                        Text(
                                          '${doc['validity in months']} Meses',
                                          style: productDetailStyle,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
