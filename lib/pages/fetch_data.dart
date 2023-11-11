import 'package:http/http.dart' as http;

const String baseUrl =
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=089001*2';

class HTTPClient {
  static Future<List<String>?> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=089001*2'));
      if (response.statusCode == 200) {
        final html = response.body;
        return html.split('\n'); // Split HTML by lines and return as a list
      }
    } catch (e) {
      print('HTTPClient: $e');
    }
    return null;
  }
}

class DataScraper {
  // Define the labels
  static final labels = [
    'Calories',
    'Total Fat',
    'Sat Fat',
    'Trans Fat',
    'Cholesterol',
    'Sodium',
    'Tot Carb',
    'Dietary Fiber',
    'Sugars',
    'Protein',
  ];

  static Map<String, num> run(List<String> htmlArray) {
    try {
      // Initialize values in the dictionary
      final nutrientData = <String, num>{};

      for (final label in labels) {
        nutrientData[label] = 0;
      }

      // Parse each line in the array
      for (final line in htmlArray) {
        findNutrients(line, nutrientData);
      }

      // Print and return the dictionary
      return nutrientData;
    } catch (e) {
      print('DataScraper: $e');
      return {};
    }
  }

  static void findNutrients(String line, Map<String, num> nutrientData) {
    for (final label in labels) {
      if (line.contains(label)) {
        if (label == 'Calories') {
          final value = findCalories(line);
          if (value != null) {
            nutrientData[label] = value;
          }
        } else {
          final value = findValue(line);
          if (value != null) {
            nutrientData[label] = value;
          }
        }
      }
    }
  }

  static num? findValue(String line) {
    final matches = RegExp(r'(\d+)[\s]*(g|mg)').allMatches(line);
    if (matches.isNotEmpty) {
      final match = matches.first;
      final value = int.tryParse(match.group(1)!) ?? 0;
      final unit = match.group(2);

      // Convert values to milligrams if the unit is 'g'
      return value;
    }
    return null;
  }

  static num? findCalories(String line) {
    final afterCalories =
        line.substring(line.indexOf('Calories') + 'Calories'.length);

    final match = RegExp(r'(\d+)').firstMatch(afterCalories);

    if (match != null) {
      final value = int.tryParse(match.group(1)!) ?? 0;
      return value;
    }
    return null;
  }

}


Future<Map<String, num>?> readData() async {
  final html = await HTTPClient.fetchData();

  if (html != null) {
    final nutrientData = DataScraper.run(html);
    return nutrientData;
  }

  return null;
}


