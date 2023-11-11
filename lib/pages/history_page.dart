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
  HistoryPage({Key? key, required this.exportedItems, required this.macros})
      : super(key: key);
  final List<String> exportedItems;
  final List<double> macros;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> exportedItems = [];
  List<double> macros = [];

  @override
  void initState() {
    super.initState();
    // print("init length");
    // print(widget.exportedItems.length);
    if (widget.exportedItems != []) {
      exportedItems = widget.exportedItems;
      macros = widget.macros;
    }
    // print(widget.exportedItems.length);
  }

  @override
  Widget build(BuildContext context) {
    List<String> emptyState = [];
    return Consumer<AppDataProvider>(builder: (context, appData, child) {
      if (!(listEquals(exportedItems, emptyState))) {
        appData.updateMacroHistory(macros);
        appData.updateExportedItemsHistory(exportedItems);
      }
      // print("build list");
      // print(exportedItems.runtimeType);
      // print(emptyState.runtimeType);
      // print(listEquals(exportedItems[0], emptyState[0]));
      int histLen = appData.appData.exportedItemsHistory.length;
      // print(histLen);
      if (histLen == 0) {
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
                'title': appData.appData.exportedItemsHistory[index].toString(),
                'description': 'Carbs: ' +
                    appData.appData.macrosHistory[index][0].toString() +
                    ', Protein: ' +
                    appData.appData.macrosHistory[index][1].toString() +
                    ', Fats: ' +
                    appData.appData.macrosHistory[index][2].toString(),
              });
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
