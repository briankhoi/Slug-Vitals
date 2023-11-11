import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nibbles/data/app_data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.dailyValues, required this.macros})
      : super(key: key);

  final List<double> dailyValues;
  final List<double> macros;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<double> dailyValues = List.filled(6, 0.0);
  List<double> macros = [0.0, 0.0, 0.0];
  // List<double> progressValues = List.filled(6, 0.0);
  // List<double> macroIndicator = [0.0, 0.0, 0.0];
  // double macroSum = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < dailyValues.length; i++) {
      dailyValues[i] += widget.dailyValues[i];
      if (i < 3) {
        macros[i] += widget.macros[i];
      }
    }
  }

  // List<double> thresholds = [100.0, 100.0, 100.0, 100.0, 100.0, 100.0];
  // dv thresholds

  // nutrition statistics
  List<String> nut = [
    'Fiber',
    'Sugar',
    'Cholesterol',
    'Sodium',
    'Sat. Fat',
    'Trans. Fat'
  ];

  int calories = 1009;

  List<String> macroTitles = [
    'Fats',
    'Carbs',
    'Protein'
  ]; // Titles for the sections
  List<Color> macroColors = [
    Colors.green.shade600, // Protein
    Colors.green.shade400, // Fat
    Colors.green.shade300, // Carbs
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(builder: (context, appData, child) {
      return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Nexa',
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Dashboard',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor:
                Colors.green.shade300, // Set the background color of the AppBar
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
                              appData.appData.macrosIndicator.length,
                              (index) {
                                double value = appData.appData.macrosIndicator[index];
                                return PieChartSectionData(
                                  color: macroColors[index],
                                  value: value * 100,
                                  radius: 50,
                                  title: macroTitles[index],
                                  titleStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
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
                        Text(
                          calories.toString(),
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF42434F)),
                        ),
                        Text(
                          'cal',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF42434F)),
                        ),
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
                  padding: const EdgeInsets.all(
                      16.0), // Adjust the padding as needed
                  child: Container(
                    height: MediaQuery.of(context).size.height /
                        2, // Adjust the fraction as needed
                    decoration: BoxDecoration(
                      color: Colors.green.shade300,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                            20.0), // Adjust the radius as needed
                        bottom: Radius.circular(
                            20.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Column(
                      children: List.generate(
                        nut.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                nut[index],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Container(
                                width:
                                    200, // Adjust the width of the progress bar
                                child: LinearProgressIndicator(
                                  value: appData.appData.dailyValuesIndicator[
                                      index], // Set the progress value based on your requirements
                                  minHeight:
                                      30, // Adjust the height of the progress bar
                                  backgroundColor: Colors
                                      .white, // Background color of the progress bar
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors
                                          .green), // Color of the progress bar
                                  borderRadius: BorderRadius.circular(
                                      25.0), // round the edges
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
    });
  }
}
