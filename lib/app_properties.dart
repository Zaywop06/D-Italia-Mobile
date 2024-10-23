import 'package:flutter/material.dart';

const Color yellow = Color(0xffFFD4B6);
const Color mediumYellow = Color.fromARGB(255, 255, 209, 179);
const Color darkYellow = Color(0xffFF9F6D);
const Color transparentYellow = Color.fromRGBO(255, 239, 226, 0.7);
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(0, 0, 0, 1),
  Color.fromRGBO(0, 0, 0, 1),
  Color.fromRGBO(0, 0, 0, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}