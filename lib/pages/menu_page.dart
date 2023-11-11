import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var diningHalls = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [
      ['a', 'b', 'c']
    ],
    'Stevenson & Cowell': [
      ['Allergen Free Halal Chicken', 'stat1', 'stat2'],
      ['Apple Pie', 'stat1', 'stat2'],
      ['Harissa Tofu', 'stat1', 'stat2'],
    ],
    'Kresge': [
      ['1', '2', '3']
    ],
    'Porter': [
      ['1', '2', '3']
    ],
  };

  var itemBools = {
    'John R. Lewis & College Nine': [
      false,
    ],
    'Stevenson & Cowell': [false, false, false],
    'Kresge': [
      false,
    ],
    'Porter': [
      false,
    ],
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

  void updateForm(int index) {
    if (itemBools[currentHall] != null) {
      setState(() {
        itemBools[currentHall]?[index] = !itemBools[currentHall]![index];
      });
    }
  }

  void submitForm() {
    // reset all to false

    return;
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
            color: Colors.amber.shade200,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular((20))),
          ),
          child: Center(
            child: Text(currentHall),
          ),
        )));

    // retrieve menu items from map
    List<Padding> getChildren() {
      List<Padding> items = [];
      for (int i = 0; i < diningHalls[currentHall]!.length; i++) {
        // bool checkboxValue = false;
        Padding item = Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CheckboxListTile(
                title: Text(
                    diningHalls[currentHall]?.elementAt(i).elementAt(0) ?? ''),
                value: itemBools[currentHall]?.elementAt(i),
                onChanged: (bool? value) {
                  updateForm(i);
                }));
        items.add(item);
      }
      return items;
    }

    Widget menuItems = Column(
      children: getChildren(),
    );
    print(diningHalls[currentHall]);
    return MaterialApp(
      theme:
          ThemeData(colorSchemeSeed: Colors.green.shade300, useMaterial3: true),
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
              )),
          menuItems,
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FilledButton(
                // color: Colors.green.shade300,
                onPressed: submitForm,
                child: const Text('Filled')),
          ),
        ],
      )),
    );
  }
}
