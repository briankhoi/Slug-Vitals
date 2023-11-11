import 'package:flutter/material.dart';
import 'package:nibbles/data/app_data.dart';
import 'package:provider/provider.dart';
import 'pages/add_page.dart';
import 'pages/history_page.dart';
import 'pages/home_page.dart';
import 'pages/fetch_data.dart';

// Variable to store the nutrient data globally
Map<String, num>? nutrientData;

void main() async {
  nutrientData = await readData();
  // if (nutrientData != null) {
  //   print(nutrientData);
  // } else {
  //   print('Failed to fetch nutrient data.');
  // }
  runApp(ChangeNotifierProvider(
    create: (context) => AppDataProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var web_scrape_data;

  // List<double> daily_values = [50, 64, 21, 8, 32, 95];
  List<double> daily_values = List.filled(6, 0);
  List<double> macros = [100, 50, 12];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(builder: (context, appData, child) {
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
                  HomePage(
                    dailyValues: daily_values,
                    macros: macros,
                  ),
                  AddPage(
                    macros: appData.appData.macrosMap,
                    foodsList: appData.appData.foodsMap,
                  ),
                  // MenuPage(),
                  // resolve these errors
                  HistoryPage(
                    exportedItems: [],
                    macros: [],
                  ),
                ],
              )),
        ),
      );
    });
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
