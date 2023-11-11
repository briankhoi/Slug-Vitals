import 'package:nibbles/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nibbles/data/app_data.dart';

class MenuPage extends StatefulWidget {
  // MenuPage({super.key, required currentHall});
  MenuPage(
      {Key? key,
      required this.currentHall,
      required this.macros,
      required this.foodsList})
      : super(key: key);
  final String currentHall;
  final Map<String, List<List<double>>> macros;
  final Map<String, List<String>> foodsList;
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String currentHall = '';
  Map<String, List<String>> foodsList = {};
  Map<String, List<List<double>>> macrosList = {};

  @override
  void initState() {
    super.initState();
    currentHall = widget.currentHall;
    macrosList = widget.macros;
    foodsList = widget.foodsList;
  }

  late Map<String, List<bool>> itemBools = {
    'John R. Lewis & College Nine':
        List.filled(foodsList['John R. Lewis & College Nine']!.length, false),
    'Stevenson & Cowell':
        List.filled(foodsList['Stevenson & Cowell']!.length, false),
    'Crown & Merill': List.filled(foodsList['Crown & Merill']!.length, false),
    'Porter & Kresge': List.filled(foodsList['Porter & Kresge']!.length, false),
    'Rachel Carson & Oakes':
        List.filled(foodsList['Rachel Carson & Oakes']!.length, false),
  };

  void updateHall(int updateValue) {
    List<String> keys = foodsList.keys.toList();
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
            color: Colors.green.shade300,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular((20))),
          ),
          child: Center(
            child: Text(currentHall),
          ),
        )));

    // retrieve menu items from map
    // print(foodsList[currentHall]);

    return Consumer<AppDataProvider>(builder: (context, appData, child) {
      print(appData.appData.foodsMap);
      print("bruh1");
      print(appData.appData.foodsMap['John R. Lewis & College Nine']![0]);
      void submitForm() {
        // reset all to false
        // list of strings of food names submitted, last element is timestamp
        List<String> exportedItems = [];
        // list of doubles of macros - carbs, proteins, fat
        List<String> keys = itemBools.keys.toList();
        List<List<int>> indexTracker = [];
        for (int i = 0; i < keys.length; i++) {
          for (int j = 0; j < itemBools[keys[i]]!.length; j++) {
            bool status = itemBools[keys[i]]![j];
            if (status) {
              exportedItems.add(foodsList[keys[i]]![j]);
              indexTracker.add([i, j]);
              setState(() {
                itemBools[keys[i]]![j] = false;
              });
            }
          }
        }
        // int timestamp = DateTime.now();
        DateTime tsdate = DateTime.now();
        String datetime = tsdate.month.toString() +
            "/" +
            tsdate.day.toString() +
            "/" +
            tsdate.year.toString();
        exportedItems.add(datetime);
        ;
        print(indexTracker);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryPage(
                    indexTracker: indexTracker,
                    exportedItems: exportedItems,
                    // macros: macros,
                  )),
        );
        return;
      }

      List<Padding> getChildren() {
        List<Padding> items = [];
        for (int i = 0;
            i < appData.appData.foodsMap[currentHall]!.length;
            i++) {
          // bool checkboxValue = false;
          Padding item = Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: CheckboxListTile(
                  title: Text(
                      appData.appData.foodsMap[currentHall]?.elementAt(i) ??
                          ''),
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
      return MaterialApp(
        theme: ThemeData(
            colorSchemeSeed: Colors.green.shade300, useMaterial3: true),
        home: Scaffold(
            body: ListView(
          children: [
            AppBar(
              backgroundColor: Colors.green.shade300,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Navigator.pop(context);
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
                  child: const Text('Submit')),
            ),
          ],
        )),
      );
    });
  }
}
