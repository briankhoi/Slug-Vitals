import 'package:flutter/material.dart';
import 'pages/add_page.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'pages/menu_page.dart';
import 'pages/fetch_data.dart';

// Variable to store the nutrient data globally
Map<String, num>? nutrientData;

void main() async {
  final nutrientData = await readData();
  print("Hello world");
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
                HistoryPage(),
              ],
            )),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: Color(0xFF3F5AA6),
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.directions_car),
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
