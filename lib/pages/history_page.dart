import 'package:flutter/material.dart';

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
    exportedItems.add(widget.exportedItems);
    macros.add(widget.macros);
  }

  @override

  Widget build(BuildContext context) {
    int histLen = exportedItems.length;
    List<Map<String, dynamic>> _items = List.generate(
        histLen,
        (index) => {
              'id': index,
              'title': exportedItems[index].toString(),
              'description': 'Carbs: ' + macros[index][0].toString() + ', Protein: ' + macros[index][1].toString() + ', Fats: ' +  macros[index][2].toString(),
            });

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nexa',
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade300,
          title: Text("History"),
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
  }
}
