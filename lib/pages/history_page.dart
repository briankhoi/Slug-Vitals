import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nibbles/data/app_data.dart';
import './home_page.dart';
import './add_page.dart';
import './history_page.dart';
// import 'pages/home_page.dart';
import './fetch_data.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage(
      {Key? key,
      required this.exportedItems,
      // required this.macros,
      required this.indexTracker})
      : super(key: key);
  final List<String> exportedItems;
  // final List<double> macros;
  final List<List<int>> indexTracker;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> exportedItems = [];
  List<double> macros = [];
  List<List<int>> indexTracker = [];

  @override
  void initState() {
    super.initState();
    if (widget.exportedItems != []) {
      exportedItems = widget.exportedItems;
      indexTracker = widget.indexTracker;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> emptyState = [];
    List<String> navState = ['1'];
    print(exportedItems);
    print(exportedItems);
    return Consumer<AppDataProvider>(builder: (context, appData, child) {
      if (!(listEquals(exportedItems, emptyState)) && !listEquals(exportedItems, navState)) {
        appData.updateExportedItemsHistory(exportedItems);
        // fn to access dailyvaluesmap and add the required data from exported items to dv total
        for (int i = 0; i < indexTracker.length; i++) {
          List<double> neededDailyValues = [];
          int a = indexTracker[i][0];
          int b = indexTracker[i][1];
          Map<String, List<List<double>>> DV_map =
              appData.appData.dailyValuesMap;
          List<double> DVs = DV_map[DV_map.keys.toList()[a]]![b];

          // log calories
          appData.updateCalories(DVs[0]);

          // add 6 daily values that we keep track of
          neededDailyValues.add(DVs[4]);
          neededDailyValues.add(DVs[6]);
          neededDailyValues.add(DVs[7]);
          neededDailyValues.add(DVs[9]);
          neededDailyValues.add(DVs[3]);
          neededDailyValues.add(DVs[5]);
          appData.updateDailyValuesTotal(neededDailyValues);
          appData.updateDailyValuesIndicator(appData.appData.dailyValuesTotal);

          // log macros
          List<double> macros = [];
          macros.add(DVs[2]);
          macros.add(DVs[8]);
          macros.add(DVs[1]);
          appData.updateMacroHistory(macros);
          appData.updateMacrosTotal(macros);
          appData.updateMacrosIndicator(macros);
        }
      }

      int histLen = appData.appData.exportedItemsHistory.length;
      // print(histLen);
      if (histLen == 1 && listEquals(exportedItems, emptyState)) {
        // if (listEquals(exportedItems, emptyState)) {
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
      List<Map<String, dynamic>> _items = [];
      // if (appData.appData.exportedItemsHistory.isNotEmpty) {
      _items = List.generate(
          histLen,
          (index) => {
                'id': index,
                'title': appData.appData.exportedItemsHistory[index].toString(),
                'description': 'Carbs: ' +
                    appData.appData.macrosHistory[index][0].toString() +
                    ', Protein: ' +
                    appData.appData.macrosHistory[index][1].toString() +
                    ', Fats: ' +
                    appData.appData.macrosHistory[index][2].toString(),
              });
      // }
      return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Nexa',
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade300,
            title: Text("History"),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          body: SingleChildScrollView(
            child: ExpansionPanelList.radio(
              materialGapSize: 0,
              children: _items
                  .map((e) => ExpansionPanelRadio(
                      value: e,
                      headerBuilder: (BuildContext context, bool isExpanded) =>
                          ListTile(
                            title: Text(e['title'].toString()),
                          ),
                      body: Container(
                        child: Text(e['description']),
                      )))
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}
