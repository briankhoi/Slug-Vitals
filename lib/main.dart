import 'package:flutter/material.dart';
import 'pages/add_page.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'pages/menu_page.dart';
import 'pages/fetch_data.dart';
import 'pages/menu_page.dart';

// Variable to store the nutrient data globally
Map<String, List<num>> nutrientData = {};

void main() async {
  final nutrientData = await readData();
  if (nutrientData != null) {
    print(nutrientData);
  } else {
    print('Failed to fetch nutrient data.');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var web_scrape_data;
  Map<String, List<String>> foodsList = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [
      'Crispy Bacon',
      'Hard-boiled Cage Free Egg (1)',
      'Natural Bridges Tofu Scramble',
      'Organic Gluten-Free Oatmeal',
      'Shredded Hash browns',
      'Texas French Toast'
    ],
    'Stevenson & Cowell': [
      'Allergen Free Halal Chicken',
      'Apple Pie',
      'food 1',
    ],
    'Crown & Merill': [
      'food1',
    ],
    'Porter & Kresge': [
      'food 1',
    ],
    'Rachel Carson & Oakes': [
      'food 1',
    ],
  };

  late Map<String, List<List<double>>> macrosList = {
    'John R. Lewis & College Nine': List.filled(
        foodsList['John R. Lewis & College Nine']!.length, [1.0, 1.0, 1.0]),
    'Stevenson & Cowell':
        List.filled(foodsList['Stevenson & Cowell']!.length, [1.0, 1.0, 1.0]),
    'Crown & Merill':
        List.filled(foodsList['Crown & Merill']!.length, [1.0, 1.0, 1.0]),
    'Porter & Kresge':
        List.filled(foodsList['Porter & Kresge']!.length, [1.0, 1.0, 1.0]),
    'Rachel Carson & Oakes': List.filled(
        foodsList['Rachel Carson & Oakes']!.length, [1.0, 1.0, 1.0]),
  };

  List<double> daily_values = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SlugHealth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            bottomNavigationBar: menu(),
            body: TabBarView(
              children: [
                HomePage(),
                AddPage(macros: macrosList, foodsList: foodsList,),
                // MenuPage(),
                // resolve these errors
                HistoryPage(exportedItems: [], macros: [],),
              ],
            )
          ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: Colors.green.shade300,
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.green.shade500,
      tabs: [
        Tab(
          text: "Dashboard",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "Add",
          icon: Icon(Icons.add_circle_outline),
        ),
        Tab(
          text: "History",
          icon: Icon(Icons.history),
        ),
      ],
    ),
  );
}
