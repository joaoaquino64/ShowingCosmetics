// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

const showingCosmeticsStyle = TextStyle(
  fontFamily: 'Cookie',
  fontSize: 36,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

final header = Container(
  margin: EdgeInsets.fromLTRB(20, 40, 33, 31),
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
  fontSize: 17,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productClassStyle = TextStyle(
  color: Color(0xFF007B09),
  fontFamily: 'Andada Pro',
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productNameStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 15,
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

const categoryStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 20,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const dialogTitleStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 20,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w900,
);

const textClas = '''Class 1 = Produtos SEM comprovação de eficácia\n\n
Class 2 = Produtos COM eficácia comprovada cientificamente''';

const productDetailNameStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 25,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productDetailClassStyle = TextStyle(
  color: Color(0xFF007B09),
  fontFamily: 'Andada Pro',
  fontSize: 20,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productDetailStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
);

const productDetailFieldStyle = TextStyle(
  fontFamily: 'Andada Pro',
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
);

class Category extends StatelessWidget {
  String form;

  Category(this.form);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(form, style: categoryStyle),
              SizedBox(
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/category', arguments: form),
                  child: Image.asset('images/arrow_forward.png'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
