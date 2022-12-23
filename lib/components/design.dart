import 'package:flutter/material.dart';
//import 'package:flutter_svg_provider/flutter_svg_provider.dart';

BoxDecoration boxDecoration() {
  return const BoxDecoration(
    color: Color.fromRGBO(71, 73, 115, 1),
    image: DecorationImage(
      image: AssetImage("assets/bg.png"),
      fit: BoxFit.fill,
    ),
  );
}

BoxDecoration boxOverlayDecoration() {
  return const BoxDecoration();
}
