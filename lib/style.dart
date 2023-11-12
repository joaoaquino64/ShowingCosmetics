// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

const showingCosmeticsStyle = TextStyle(
  fontFamily: 'Cookie',
  fontSize: 36,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

final header = Container(
  margin: EdgeInsets.fromLTRB(19, 40, 33, 31),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          Text('Showing', style: showingCosmeticsStyle),
          Text('Cosmetics', style: showingCosmeticsStyle),
        ],
      ),
      Container(width: 60, height: 60, child: Image.asset('images/logo.png'))
    ],
  ),
);

const productFormStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productClassStyle = TextStyle(
  color: Color(0xFF007B09),
  fontFamily: 'Andada Pro',
  fontSize: 13,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productNameStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 13,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productPreviewStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'Andada Pro',
  fontSize: 12,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const titleStyle = TextStyle(
  color: Color(0xFF007B09),
  fontFamily: 'Andada Pro',
  fontSize: 20,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

final navBar = BottomNavigationBar(
  backgroundColor: Colors.white,
  fixedColor: Color(0xFFB8ECBC),
  currentIndex: 1,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.menu, color: Colors.black),
      label: 'Menu',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.black),
      label: 'Início',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star, color: Colors.black),
      label: 'Favoritos',
    )
  ],
);
