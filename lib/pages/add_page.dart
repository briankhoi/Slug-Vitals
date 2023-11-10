import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nexa'),
      title: 'Cruz Nibbles',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cruz Nibbles'),
        ),
        body: GridView.count(
          // create two columns
          crossAxisCount: 2,
          // Generate 5 widgets, one for each dining hall
          children: List.generate(5, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }),
        ),
      ),
    );
  }
}