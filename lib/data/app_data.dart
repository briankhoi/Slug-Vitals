import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppData {
// history info
  List<List<String>> exportedItemsHistory = [];
  List<List<double>> macrosHistory = [];
// dashboard info
  List<double> dailyValuesTotal = List.filled(6, 0.0);
  // % float values
  List<double> dailyValuesIndicator = List.filled(6, 0.0);
  List<double> macrosTotal = List.filled(3, 0.0);
  List<double> macrosIndicator = List.filled(3, 0.0);
  List<double> thresholds = List.filled(6, 100.0);
// food info
  Map<String, List<List<double>>> macrosMap = {};
  Map<String, List<String>> foodsMap = {};
}

class AppDataProvider with ChangeNotifier {
  AppData _appData = AppData();

  AppData get appData => _appData;

  void updateMacroHistory(List<double> newData) {
    _appData.macrosHistory.add(newData);
    notifyListeners();
  }

  void updateExportedItemsHistory(List<String> newData) {
    _appData.exportedItemsHistory.add(newData);
    notifyListeners();
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

  void updateMacrosMap(Map<String, List<List<double>>> newData) {
    _appData.macrosMap = newData;
    notifyListeners();
  }

  void updateFoodsMap(Map<String, List<String>> newData) {
    _appData.foodsMap = newData;
    notifyListeners();
  }
}
