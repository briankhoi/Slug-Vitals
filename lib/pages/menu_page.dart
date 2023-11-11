import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var diningHalls = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [('a', 'b', 'c')],
    'Stevenson & Cowell': [('1', '2', '3')],
    'Kresge': [('1', '2', '3')],
    'Porter': [('1', '2', '3')],
  };
  String currentHall = 'Stevenson & Cowell';

  void updateHall(int updateValue) {
    List<String> keys = diningHalls.keys.toList();
    int index = keys.indexOf(currentHall);
    int newIndex = index + updateValue;
    print(newIndex);
    if (newIndex >= 0 || newIndex < keys.length) {
      setState(() {
        currentHall = keys[newIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget leftArrow = GestureDetector(
      onTap: () {
        updateHall(-1);
      },
      child: Icon(Icons.chevron_left),
    );

    Widget rightArrow = GestureDetector(
      onTap: () {
        updateHall(1);
      },
      child: Icon(Icons.chevron_right),
    );

    Widget diningHall = Container(
        padding: const EdgeInsets.all(10),
        width: 300,
        height: 60,
        child: Center(
            child: Container(
          width: 280,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.amber[50],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular((20))),
          ),
          child: Center(
            child: Text(currentHall),
          ),
        )));

    return MaterialApp(
      // color: Colors.red.shade100,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
          body: ListView(
        children: [
          AppBar(
            backgroundColor: Colors.green.shade300,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text('Menu'),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  leftArrow,
                  diningHall,
                  rightArrow,
                ],
              ))
          // menuItems,
        ],
      )),
    );
  }
}
