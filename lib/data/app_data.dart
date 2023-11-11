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
  List<double> thresholds = [30.0, 50.0, 500.0, 1000.0, 100.0, 40.0];
// food info
  Map<String, List<String>> foodsMap = {
    // keys are dining hall names
    'John R. Lewis & College Nine': [],
    'Stevenson & Cowell': [],
    'Crown & Merill': [],
    'Porter & Kresge': [],
    'Rachel Carson & Oakes': [],
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
  }

  void updateMacroHistory(List<double> newData) {
    _appData.macrosHistory.add(newData);
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
  }

  void updateDailyValuesIndicator(List<double> newData) {
    for (int i = 0; i < 6; i++) {
      _appData.dailyValuesIndicator[i] = newData[i] / _appData.thresholds[i];
    }
  }

  void updateMacrosTotal(List<double> newData) {
    for (int i = 0; i < 3; i++) {
      _appData.macrosTotal[i] += newData[i];
    }
  }

  void updateMacrosIndicator(List<double> newData) {
    double sum = 0;
    for (int i = 0; i < 3; i++) {
      sum += _appData.macrosTotal[i];
    }
    for (int i = 0; i < 3; i++) {
      _appData.macrosIndicator[i] = _appData.macrosTotal[i] / sum;
    }
  }

  void updateMacrosMap(String key, Map<String, List<List<double>>> newData) {
    _appData.macrosMap = newData;
  }

  void updateFoodsMap(String key, String newData) {
    _appData.foodsMap[key]!.add(newData);
  }

  void directUpdateMacrosMap(Map<String, List<List<double>>> newData) {
    _appData.macrosMap = newData;
  }

  void directUpdateFoodsMap(Map<String, List<String>> newData) {
    _appData.foodsMap = newData;
  }

  void updateDailyValuesMap(String key, List<double> newData) {
    _appData.dailyValuesMap[key]!.add(newData);
  }
}
