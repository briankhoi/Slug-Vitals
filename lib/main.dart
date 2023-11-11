import 'package:flutter/material.dart';
import 'pages/add_page.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'pages/menu_page.dart';
import 'fetch_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var web_scrape_data;
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
    'Crown & Merill': [
      ['1', '2', '3'],
    ],
    'Porter & Kresge': [
      ['1', '2', '3'],
    ],
    'Rachel Carson & Oakes': [
      ['1', '2', '3'],
    ],
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
                AddPage(),
                // MenuPage(),
                // resolve these errors
                HistoryPage(),
              ],
            )),
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
          text: "Home",
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
