import 'package:flutter/material.dart';

class Nav {
  static void to(BuildContext context, Widget route) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => route));
  }

  static void goto(BuildContext context, Widget route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));
  }
}
