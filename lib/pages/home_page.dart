import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'screen/main.dart';
import 'pages/menu_page.dart';

Map<String, num> dv_accumulated = {
  'Calories': 0,
  'Total Fat': 0,
  'Tot. Carb.': 0,
  'Sat. Fat': 0,
  'Dietary Fiber': 0,
  'Trans Fat': 0,
  'Sugars': 0,
  'Cholesterol': 0,
  'Protein': 0,
  'Sodium': 0,
};

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> hist = history;
  Map<String, List<num>> data = nutrientData;
  List<String> nut = ['Fiber', 'Sugar', 'Cholesterol', 'Sodium', 'Sat Fat', 'Trans Fat'];
  List<double> progressValues = [0.0, 0.0, 0.0, 0.0, 0, 0.0]; // values only change this!!
  List<double> macro = [0.0, 0.0, 0.0]; // Adjust the values as needed
  int calories = 0;
  List<String> macroTitles = ['Fat', 'Carbs', 'Protein']; // Titles for the sections
  List<Color> macroColors = [
    Colors.green.shade600, // Protein
    Colors.green.shade400, // Fat
    Colors.green.shade300, // Carbs
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nexa',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green.shade300, // Set the background color of the AppBar
          elevation: 0, // Remove the shadow
        ),
        body: Stack(
          children: [
            Positioned(
              top: 20, // PI CHART AND 1000 CAL
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 40,
                          sectionsSpace: 0,
                          startDegreeOffset: -90,
                          sections: List.generate(
                            macro.length,
                                (index) {
                              final double value = macro[index];
                              return PieChartSectionData(
                                color: macroColors[index],
                                value: value * 100,
                                radius: 50,
                                title: macroTitles[index],
                                titleStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(calories.toString(), style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold, color: Color(0xFF42434F)),),
                      Text('cal', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF42434F)),),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0, // GREEN BOX
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              nut[index],
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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
          ],
        ),
      ),
    );
  }

  void update_dvs() {
      if (history.isNotEmpty && nutrientData != null) {
        for (List<String> meal in history) {
          String date = meal.last;
          List<num>? nutrientValues = nutrientData![date];

          if (nutrientValues != null && nutrientValues.length == dv_accumulated.length) {
            for (int i = 0; i < nutrientValues.length; i++) {
              dv_accumulated[dv_accumulated.keys.elementAt(i)] += nutrientValues[i] ?? 0;
            }
          }
        }
      }
  }
}

void main() {
  runApp(HomePage());
}
