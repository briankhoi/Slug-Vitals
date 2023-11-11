// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart';

//
// class DataFetchingService {
//   // Base URL for the dining hall menu site
//   static const String baseUrl = 'https://nutrition.sa.ucsc.edu/';
//
//   // Fetch the menu data for a specific dining hall
//   Future<Map<String, dynamic>> fetchDiningHallMenu(String locationName) async {
//     final response = await http.get(Uri.parse('$baseUrl/shortmenu.aspx?sName=UC+Santa+Cruz+Dining&locationName=$locationName&naFlag=1'));
//
//     if (response.statusCode == 200) {
//       // If server returns an OK response, parse the HTML
//       final document = parse(response.body);
//

//       // Extract the data you need from the HTML document
//       final String breakfastLink = document.querySelector('#idForLink${locationName}01')?.attributes['href'] ?? '';
//       final String lunchLink = document.querySelector('#idForLink${locationName}02')?.attributes['href'] ?? '';
//       final String dinnerLink = document.querySelector('#idForLink${locationName}03')?.attributes['href'] ?? '';
//       // Return the extracted data
//       return {
//         'locationName': locationName,
//         'breakfastLink': '$baseUrl$breakfastLink',
//         'lunchLink': '$baseUrl$lunchLink',
//         'dinnerLink': '$baseUrl$dinnerLink',
//       };
//     } else {
//       // If the server did not return a 200 OK response,
//       // throw an exception.
//       throw Exception('Failed to load menu for $locationName');
//     }
//   }


//
//   // Fetch the nutrition data for a specific meal and dining hall
//   Future<Map<String, dynamic>> fetchNutritionData(String mealLink) async {
//     final response = await http.get(Uri.parse(mealLink));
//
//     if (response.statusCode == 200) {
//       // If server returns an OK response, parse the HTML
//       final document = parse(response.body);
//
//       // Extract the data you need from the HTML document
//       // Adjust the selector and extraction logic based on the actual structure of the website.
//       final String exampleData = document.querySelector('.example-class')?.text ?? '';
//
//       // Return the extracted data
//       return {'exampleData': exampleData};
//     } else {
//       // If the server did not return a 200 OK response,
//       // throw an exception.
//       throw Exception('Failed to load nutrition data');
//     }
//   }
// }
