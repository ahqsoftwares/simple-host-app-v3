// ignore_for_file: file_names
// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

class Information extends StatelessWidget {
  Information({Key? key, required this.child, this.breadth}) : super(key: key);

  final Widget child;
  double? breadth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 24, 24, 24),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(20.0),
      height: breadth,
      child: child,
    );
  }
}
