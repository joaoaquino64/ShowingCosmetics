// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'style.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});
  final db = FirebaseFirestore.instance;

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
              margin: EdgeInsets.symmetric(horizontal: 148),
              child: Text(
                'Categorias',
                style: titleStyle,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: navBar,
    );
  }
}
