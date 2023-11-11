import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override

  int histLen = 10;


  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _items = List.generate(
      histLen,
        (index) => {
        'id': index,
          'title': 'Item $index',
          'description':
              'description for item $index',
        }
    );

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
            children: _items.map((e) => ExpansionPanelRadio(
              value: e,
              headerBuilder: (BuildContext context, bool isExpanded) => ListTile(
                title: Text(e['title'].toString()),
              ),
              body: Container(
                child: Text(e['description']),
              ))).toList(),
          ),
        ),
      ),
    );
  }
}