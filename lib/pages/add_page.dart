import 'package:flutter/material.dart';
import 'package:nibbles/pages/menu_page.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(child: MenuPage())
        // MenuPage(),
      ],
    ));
  }
}