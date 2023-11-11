import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> buttonNames = ['College 9/Lewis', 'Cowell/Stevenson', 'Crown/Merill', 'Porter/Kresge', 'Rachel Carson/Oakes', 'Scan Nutrition Label'];
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



                      // Don't need to touch anything after this
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                      ),
                      fixedSize: Size(160,160),
                      primary: Colors.green.shade300,
                    ),
                    child: Text(
                      '${buttonNames[index]}',
                      style: TextStyle(fontFamily: 'Nexa', fontSize: 20,),
                    ),
                  ),
                  SizedBox(height: 8), // Optional spacing between button and text

                ],
              ),
            );
          }),),
        ),
      ),
    );
  }
}
