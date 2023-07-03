import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'DatabaseHelper.dart';
import 'FoodTaskData.dart';
import 'FoodMasterData.dart';
import 'HistoryData.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class SummaryModel {
  DateTime start;
  DateTime end;
  List<ChartData> weightChartLine;
  List<ChartData> calorieChartLine;
  List<ChartData> proteinChartLine;
  List<ChartData> sugarChartLine;
  List<ChartData> fatChartLine;
  SummaryModel(
      this.start,
      this.end,
      this.weightChartLine,
      this.calorieChartLine,
      this.proteinChartLine,
      this.sugarChartLine,
      this.fatChartLine);
}

class NutrientModel {
  String date;
  int protein;
  int sugar;
  int fat;
  NutrientModel(this.date, this.protein, this.sugar, this.fat);
}

class SummaryData extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;
  DateTime _startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime _endDate = DateTime.now().subtract(Duration(days: 1));
  List<String> _dateList = []; // Date Range
  List<HistoryModel> _historyList = []; // Weight/Carlore List
  List<NutrientModel> _nutrientList = []; // 3 Nutrient List
  List<FoodMasterModel> _masters = []; // Food Master List
  final SummaryModel _summaryData = SummaryModel(
      DateTime.now().subtract(const Duration(days: 8)),
      DateTime.now().subtract(const Duration(days: 1)), [], [], [], [], []);

  // Constructor method
  SummaryData() {
    fetchMasterData();
    _updateDateList();
    _createListData();
    _createChartData();
  }

  // Reset method
  void changeDate(String target, DateTime date) {
    if (target == 'start') {
      _startDate = date;
    } else {
      _endDate = date;
    }
    if (_endDate.compareTo(_startDate) >= 0) {
      _updateDateList();
      _createListData();
    }
  }

  void _createChartData() {
    _summaryData.start = _startDate;
    _summaryData.end = _endDate;
    _summaryData.weightChartLine = _historyList
        .asMap()
        .entries
        .map((entry) =>
            ChartData(entry.value.date, entry.value.weight.toDouble()))
        .toList();
    _summaryData.calorieChartLine = _historyList
        .asMap()
        .entries
        .map((entry) =>
            ChartData(entry.value.date, entry.value.calorie.toDouble()))
        .toList();
    _summaryData.proteinChartLine = _nutrientList
        .asMap()
        .entries
        .map((entry) =>
            ChartData(entry.value.date, entry.value.protein.toDouble()))
        .toList();
    _summaryData.sugarChartLine = _nutrientList
        .asMap()
        .entries
        .map((entry) =>
            ChartData(entry.value.date, entry.value.sugar.toDouble()))
        .toList();
    _summaryData.fatChartLine = _nutrientList
        .asMap()
        .entries
        .map((entry) => ChartData(entry.value.date, entry.value.fat.toDouble()))
        .toList();
    notifyListeners();
  }

  void _updateDateList() {
    _dateList = [];
    var term = _endDate.difference(_startDate).inDays;
    for (int i = 0; i < term + 1; i++) {
      _dateList.add(_date2Str(_startDate.subtract(Duration(days: -i))));
    }
  }

  void _createListData() {
    _dateList.forEach((date) {
      fetchHistoryData(date);
      fetcFoodhTaskData(date);
    });
    notifyListeners();
  }

  // Provide data to display
  SummaryModel getSummary() {
    _createChartData();
    return _summaryData;
  }

  // Convert methods
  String _date2Str(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  NutrientModel createNutrientItem(String date, List<FoodTaskModel> tasks) {
    NutrientModel nutrient_item = NutrientModel(date, 0, 0, 0);
    tasks.forEach((task) {
      nutrient_item.protein +=
          getTargetMaster(task.master).protein * task.volume ~/ 100.toInt();
      nutrient_item.sugar +=
          getTargetMaster(task.master).sugar * task.volume ~/ 100.toInt();
      nutrient_item.fat +=
          getTargetMaster(task.master).fat * task.volume ~/ 100.toInt();
    });
    return nutrient_item;
  }

  FoodMasterModel getTargetMaster(int target) {
    return _masters.firstWhere((master) => master.id == target);
  }

  // Fetch methods
  Future fetchHistoryData(String date) async {
    _historyList = [];
    final response = await _getDBTargetHistoryData(date);
    if (response.length == 0) {
      _historyList.add(HistoryModel(0, date, 0, 0));
    } else {
      HistoryModel history = response
          .map((item) => HistoryModel(
              item['id'], item['date'], item['weight'], item['calorie']))
          .toList()[0];
      _historyList.add(history);
    }
    notifyListeners();
  }

  Future fetcFoodhTaskData(String date) async {
    _nutrientList = [];
    final response = await _getDBTargetFoodTaskData(date);
    List<FoodTaskModel> tasks = response
        .map((item) => FoodTaskModel(
            item['id'], item['master'], item['date'], item['volume']))
        .toList();
    _nutrientList.add(createNutrientItem(date, tasks));
    notifyListeners();
  }

  Future fetchMasterData() async {
    // Masters all data 1 time call
    final response = await _getDBTargetFoodMasterData();
    _masters = response
        .map((item) => FoodMasterModel(item['id'], item['name'], item['type'],
            item['protein'], item['sugar'], item['fat'], item['calorie']))
        .toList();
    notifyListeners();
  }

  // DB methods
  Future<List<Map<String, dynamic>>> _getDBTargetHistoryData(
      String date) async {
    final targetRows =
        await dbHelper.queryTargetRows('weight_history', 'date', date);
    return targetRows;
  }

  Future<List<Map<String, dynamic>>> _getDBTargetFoodTaskData(
      String date) async {
    final targetRows =
        await dbHelper.queryTargetRows('food_task', 'date', date);
    return targetRows;
  }

  Future<List<Map<String, dynamic>>> _getDBTargetFoodMasterData() async {
    final allRows = await dbHelper.queryAllRows('food_master');
    return allRows;
  }
}
