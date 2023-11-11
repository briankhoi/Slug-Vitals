import 'package:http/http.dart' as http;

class HTTPClient {
  static Future<List<String>?> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
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
  static final labels = [
    'Calories',
    'Total Fat',
    'Tot. Carb.',
    'Sat. Fat',
    'Dietary Fiber',
    'Trans Fat',
    'Sugars',
    'Cholesterol',
    'Protein',
    'Sodium',
  ];

  static Map<String, List<num>> run(List<String> htmlArray) {
    try {
      final nutrientData = Map<String, List<num>>();
      String? title;

      // Parse each line in the array
      for (final line in htmlArray) {
        title = findTitle(line); // Assign value directly to outer title variable
        if (title != null) {
          break;
        }
      }
      nutrientData[title!] = findNutrientValues(htmlArray);

      return nutrientData;
    } catch (e) {
      print('DataScraper: $e');
      return {};
    }
  }

  static String? findTitle(String line) {
    final match = RegExp(r'<div class="labelrecipe">(.*?)<\/div>').firstMatch(line);
    return match?.group(1)?.trim();
  }

  static List<num> findNutrientValues(List<String> htmlArray) {
    final values = <num>[];

    for (final line in htmlArray) {
      for (final label in labels) {
        if (line.contains(label)) {
          num? value;

          if (label == 'Calories') {
            value = findCalories(line);
          } else {
            value = findValue(line);
          }

          if (value != null) {
            values.add(value);
          }
        }
      }
    }

    return values;
  }

  static num? findValue(String line) {
    final matches = RegExp(r'(\d+)[\s]*(g|mg)').allMatches(line);
    if (matches.isNotEmpty) {
      final match = matches.first;
      final value = double.tryParse(match.group(1)!);
      final unit = match.group(2); // Change from group(3) to group(2)

      // Convert values to milligrams if the unit is 'g'
      return value;
    }
    // Return null if no matches are found
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

Future<Map<String, List<num>>> readData() async {
  Map<String, List<num>> combinedData = {};

  List<String> foodUrls = [
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=089001*2',
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=061003*1',
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=140108*4',
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=031003*6',
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=161011*3',
    'https://nutrition.sa.ucsc.edu/label.aspx?locationNum=40&locationName=College+Nine%2fJohn+R.+Lewis+Dining+Hall&dtdate=11%2f10%2f2023&RecNumAndPort=217041*2',
  ];

  for (String url in foodUrls) {
    final html = await HTTPClient.fetchData(url);

    if (html != null) {
      final nutrientData = DataScraper.run(html);
      combinedData.addAll(nutrientData);
    }
  }

  return combinedData;
}
