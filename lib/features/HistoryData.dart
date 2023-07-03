import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';
import 'package:intl/intl.dart';

class HistoryModel {
  int id;
  String date;
  int weight;
  int calorie;
  HistoryModel(this.id, this.date, this.weight, this.calorie);
}

class HistoryData extends ChangeNotifier {
  String current_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  HistoryModel _history = HistoryModel(0, '', 0, 0);
  final dbHelper = DatabaseHelper.instance;

  HistoryData() {
    fetchHistoryData(current_date);
  }

  changeDate(String date) {
    current_date = date;
    fetchHistoryData(date);
    notifyListeners();
  }

  Future fetchHistoryData(String date) async {
    final response = await _getDBTargetData(date);
    if (response.isEmpty) {
      _history = HistoryModel(0, date, 0, 0);
    } else {
      _history = response
          .map((item) => HistoryModel(
              item['id'], item['date'], item['weight'], item['calorie']))
          .toList()[0];
    }
    notifyListeners();
  }

  HistoryModel getHistoryData() {
    return _history;
  }

  Future<List<Map<String, dynamic>>> _getDBTargetData(String date) async {
    final targetRows =
        await dbHelper.queryTargetRows('weight_history', 'date', date);
    return targetRows;
  }

  void updateHistory(HistoryModel data) async {
    _history.date = data.date;
    _history.weight = data.weight;
    _history.calorie = data.calorie;

    Map<String, dynamic> row = {
      'id': data.id,
      'date': data.date,
      'weight': data.weight,
      'calorie': data.calorie
    };
    await dbHelper.update(row, 'weight_history');
    notifyListeners();
  }

  void addHistory(HistoryModel data) async {
    Map<String, dynamic> row = {
      'date': data.date,
      'weight': data.weight,
      'calorie': data.calorie
    };
    final id = await dbHelper.insert(row, 'weight_history');
    data.id = id;
    _history = data;
    notifyListeners();
  }

  void removeHistory(int target) async {
    await dbHelper.delete(target, 'weight_history');
    notifyListeners();
  }
}

class HistoryEditModel extends ChangeNotifier {
  int _id = 0;
  String _date = '';
  int _weight = 0;
  int _calorie = 0;

  HistoryModel getEditingHistory() {
    return HistoryModel(_id, _date, _weight, _calorie);
  }

  setHistoryEditModel(HistoryModel data) {
    _id = data.id;
    _date = data.date;
    _weight = data.weight;
    _calorie = data.calorie;
    weightEditingController =
        TextEditingController(text: data.weight.toString());
  }

  TextEditingController weightEditingController = TextEditingController();

  void changeWeight(int? value) {
    if (value != null) {
      _weight = value;
    }
    notifyListeners();
  }

  void changeCalorie(int? value) {
    if (value != null) {
      _calorie = value;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    weightEditingController.dispose();
    super.dispose();
  }
}
