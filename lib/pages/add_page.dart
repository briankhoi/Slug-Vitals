import 'package:flutter/material.dart';
import 'package:nibbles/pages/menu_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key, required this.macros, required this.foodsList})
      : super(key: key);
  final Map<String, List<List<double>>> macros;
  final Map<String, List<String>> foodsList;
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Map<String, List<List<double>>> macros = {};
  Map<String, List<String>> foodsList = {};

  @override
  void initState() {
    super.initState();
    macros = widget.macros;
    foodsList = widget.foodsList;
  }

  @override
  Widget build(BuildContext context) {
    List<String> buttonNames = [
      'John R. Lewis & College Nine',
      'Stevenson & Cowell',
      'Crown & Merill',
      'Porter & Kresge',
      'Rachel Carson & Oakes',
      'Scan Nutrition Label'
    ];
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Nexa'),
      title: 'Cruz Nibbles',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add Item'),
          backgroundColor: Colors.green.shade300,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            // create two columns
            crossAxisCount: 2,
            // Generate 5 buttons, one for each dining hall
            children: List.generate(6, (index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Don't need to touch anything before this
                        // Add the link and function here
                        // Remember this is a for loop
                        print('Button $index pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuPage(
                                    currentHall: buttonNames[index],
                                    macros: macros,
                                    foodsList: foodsList,
                                  )),
                        );
                        // Don't need to touch anything after this
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Adjust the value as needed
                        ),
                        fixedSize: Size(160, 160),
                        primary: Colors.green.shade300,
                      ),
                      child: Text(
                        '${buttonNames[index]}',
                        style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 8), // Optional spacing between button and text
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
