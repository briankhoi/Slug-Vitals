import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> nut = ['Fat', 'Sugar', 'Sodium', 'Protein', 'Carbs', 'Fiber'];
  //
  List<double> progressValues = [0.5, 0.3, 0.67, 0.9, 1, 0]; // values only change this!!
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nexa',
      ),
      home: Padding(padding: EdgeInsets.only(left: 15, right: 15), child: Scaffold(
        body: Stack(
          children: [
            // Green box at the bottom half with padding
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
                child: Container(
                  height: MediaQuery.of(context).size.height / 2, // Adjust the fraction as needed
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0), // Adjust the radius as needed
                      bottom: Radius.circular(20.0), // Adjust the radius as needed
                    ),
                  ),
                  child: Column(
                    children: List.generate(
                      nut.length,
                          (index) => Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0), // Adjust margins as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              nut[index],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            Container(
                              width: 200, // Adjust the width of the progress bar
                              child: LinearProgressIndicator(
                                value: progressValues[index], // Set the progress value based on your requirements
                                minHeight: 30, // Adjust the height of the progress bar
                                backgroundColor: Colors.white, // Background color of the progress bar
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Color of the progress bar
                                borderRadius: BorderRadius.circular(25.0), // round the edges
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250, // Adjust the top position as needed
              left: 30, // Adjust the left position as needed
              child: Text(
                'At a Glance',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
      ));
  }
}
