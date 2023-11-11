import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppData {
// history info
  List<List<String>> exportedItemsHistory = [];
  List<List<double>> macrosHistory = [];
// dashboard info
  double calories = 0;
  List<double> dailyValuesTotal = List.filled(6, 0.0);
  // % float values
  List<double> dailyValuesIndicator = List.filled(6, 0.0);
  List<double> macrosTotal = List.filled(3, 0.0);
  List<double> macrosIndicator = List.filled(3, 0.0);
  List<double> thresholds = List.filled(6, 100.0);
// food info
  Map<String, List<String>> foodsMap = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [
      // 'Crispy Bacon',
      // 'Hard-boiled Cage Free Egg (1)',
      // 'Natural Bridges Tofu Scramble',
      // 'Organic Gluten-Free Oatmeal',
      // 'Shredded Hashbrowns',
      // 'Texas French Toast'
    ],
    'Stevenson & Cowell': [
      'Allergen Free Halal Chicken',
      'Apple Pie',
      'food 1',
    ],
    'Crown & Merill': [
      'food1',
    ],
    'Porter & Kresge': [
      'food 1',
    ],
    'Rachel Carson & Oakes': [
      'food 1',
    ],
  };
  Map<String, List<List<double>>> dailyValuesMap = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [],
    'Stevenson & Cowell': [],
    'Crown & Merill': [],
    'Porter & Kresge': [],
    'Rachel Carson & Oakes': [],
  };

  Map<String, List<List<double>>> macrosMap = {
    // 'John R. Lewis & College Nine': List.filled(
    //     foodsMap['John R. Lewis & College Nine']!.length, [1.0, 1.0, 1.0]),
    // 'Stevenson & Cowell':
    //     List.filled(foodsMap['Stevenson & Cowell']!.length, [1.0, 1.0, 1.0]),
    // 'Crown & Merill':
    //     List.filled(foodsMap['Crown & Merill']!.length, [1.0, 1.0, 1.0]),
    // 'Porter & Kresge':
    //     List.filled(foodsMap['Porter & Kresge']!.length, [1.0, 1.0, 1.0]),
    // 'Rachel Carson & Oakes':
    //     List.filled(foodsMap['Rachel Carson & Oakes']!.length, [1.0, 1.0, 1.0]),
    'John R. Lewis & College Nine': [],
    'Stevenson & Cowell': [],
    'Crown & Merill': [],
    'Porter & Kresge': [],
    'Rachel Carson & Oakes': [],
  };
}

class AppDataProvider with ChangeNotifier {
  AppData _appData = AppData();

  AppData get appData => _appData;

  void updateCalories(double newData) {
    _appData.calories += newData;
    notifyListeners();
  }

  void updateMacroHistory(List<double> newData) {
    _appData.macrosHistory.add(newData);
    notifyListeners();
  }

  void updateExportedItemsHistory(List<String> newData) {
    _appData.exportedItemsHistory.add(newData);
  }

  void directUpdateMacroHistory(List<List<double>> newData) {
    _appData.macrosHistory = newData;
  }

  void directUpdateExportedItemsHistory(List<List<String>> newData) {
    _appData.exportedItemsHistory = newData;
  }

  void updateDailyValuesTotal(List<double> newData) {
    for (int i = 0; i < 6; i++) {
      _appData.dailyValuesTotal[i] += newData[i];
    }
    notifyListeners();
  }

  void updateDailyValuesIndicator(List<double> newData) {
    for (int i = 0; i < 6; i++) {
      _appData.dailyValuesIndicator[i] = newData[i] / _appData.thresholds[i];
    }
    notifyListeners();
  }

  void updateMacrosTotal(List<double> newData) {
    for (int i = 0; i < 3; i++) {
      _appData.macrosTotal[i] += newData[i];
    }
    notifyListeners();
  }

  void updateMacrosIndicator(List<double> newData) {
    double sum = 0;
    for (int i = 0; i < 3; i++) {
      sum += _appData.macrosTotal[i];
    }
    for (int i = 0; i < 3; i++) {
      _appData.macrosIndicator[i] = _appData.macrosTotal[i] / sum;
    }
    notifyListeners();
  }

  void updateMacrosMap(String key, Map<String, List<List<double>>> newData) {
    _appData.macrosMap = newData;
    notifyListeners();
  }

  void updateFoodsMap(String key, String newData) {
    _appData.foodsMap[key]!.add(newData);
    notifyListeners();
  }

  void directUpdateMacrosMap(Map<String, List<List<double>>> newData) {
    _appData.macrosMap = newData;
    notifyListeners();
  }

  void directUpdateFoodsMap(Map<String, List<String>> newData) {
    _appData.foodsMap = newData;
    notifyListeners();
  }

  void updateDailyValuesMap(String key, List<double> newData) {
    _appData.dailyValuesMap[key]!.add(newData);
  }
}
