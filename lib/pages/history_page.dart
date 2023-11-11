import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './home_page.dart';
import './add_page.dart';
import './history_page.dart';
// import 'pages/home_page.dart';
import './fetch_data.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.exportedItems, required this.macros})
      : super(key: key);
  final List<String> exportedItems;
  final List<double> macros;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<List<String>> exportedItems = [];
  List<List<double>> macros = [];
  @override
  void initState() {
    super.initState();
    // print("init length");
    // print(widget.exportedItems.length);
    if (widget.exportedItems != []) {
      exportedItems.add(widget.exportedItems);
      macros.add(widget.macros);
    }
    // print(widget.exportedItems.length);
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> emptyState = [[]];
    // print("build list");
    // print(exportedItems.runtimeType);
    // print(emptyState.runtimeType);
    // print(listEquals(exportedItems[0], emptyState[0]));
    int histLen = exportedItems.length;
    // print(histLen);
    if (histLen == 1 && listEquals(exportedItems[0], emptyState[0])) {
      return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Nexa',
          ),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              title: Text("History"),
            ),
            body: Center(child: Text("No meals inputted!")),
          ));
    }
    List<Map<String, dynamic>> _items = List.generate(
        histLen,
        (index) => {
              'id': index,
              'title': exportedItems[index].toString(),
              'description': 'Carbs: ' +
                  macros[index][0].toString() +
                  ', Protein: ' +
                  macros[index][1].toString() +
                  ', Fats: ' +
                  macros[index][2].toString(),
            });

    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Nexa',
        ),
        home: Column(children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.shade300,
              title: Text("History"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                  }),
            ),
            body: SingleChildScrollView(
              child: ExpansionPanelList.radio(
                materialGapSize: 0,
                children: _items
                    .map((e) => ExpansionPanelRadio(
                        value: e,
                        headerBuilder:
                            (BuildContext context, bool isExpanded) => ListTile(
                                  title: Text(e['title'].toString()),
                                ),
                        body: Container(
                          child: Text(e['description']),
                        )))
                    .toList(),
              ),
            ),
          ),
          DefaultTabController(
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
                      macros: macrosList,
                      foodsList: foodsList,
                    ),
                    HistoryPage(
                      exportedItems: [],
                      macros: [],
                    ),
                  ],
                )),
          )
        ]));
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
