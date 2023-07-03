import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';
import 'package:intl/intl.dart';
import 'FoodMasterData.dart';

class FoodTaskModel {
  int id;
  int master;
  String date;
  int volume;
  FoodTaskModel(this.id, this.master, this.date, this.volume);
}

class FoodTaskData extends ChangeNotifier {
  List<FoodTaskModel> _tasks = [];
  List<FoodTaskModel> _all_tasks = [];
  String current_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dbHelper = DatabaseHelper.instance;

  FoodTaskData() {
    fetchTaskData(current_date);
  }

  changeDate(String date) {
    current_date = date;
    fetchTaskData(date);
    notifyListeners();
  }

  setGetAllTask() async {
    final response = await _getDBData();
    _all_tasks = response
        .map((item) => FoodTaskModel(
            item['id'], item['master'], item['date'], item['volume']))
        .toList();
    notifyListeners();
  }

  Future fetchTaskData(String date) async {
    final response = await _getDBTargetData(date);
    _tasks = response
        .map((item) => FoodTaskModel(
            item['id'], item['master'], item['date'], item['volume']))
        .toList();
    notifyListeners();
  }

  List<FoodTaskModel> getTaskList() {
    return _tasks;
  }

  int getTotalCalorie(FoodMasterData masterData) {
    int total = 0;
    if (_tasks.isNotEmpty) {
      _tasks.forEach((item) {
        total += masterData.getMasterItem(item.master).calorie *
            item.volume ~/
            100.toInt();
      });
    }
    return total;
  }

  List<FoodTaskModel> getAllTaskList() {
    return _all_tasks;
  }

  FoodTaskModel getTaskItem(int target) {
    return _tasks.firstWhere((task) => task.id == target);
  }

  Future<List<Map<String, dynamic>>> _getDBTargetData(String date) async {
    final targetRows =
        await dbHelper.queryTargetRows('food_task', 'date', date);
    return targetRows;
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('food_task');
    return allRows;
  }

  void updateTask(FoodTaskModel data) async {
    _tasks.firstWhere((item) => item.id == data.id).master = data.master;
    _tasks.firstWhere((item) => item.id == data.id).date = data.date;
    _tasks.firstWhere((item) => item.id == data.id).volume = data.volume;

    Map<String, dynamic> row = {
      'id': data.id,
      'master': data.master,
      'date': data.date,
      'volume': data.volume
    };
    await dbHelper.update(row, 'food_task');
    notifyListeners();
  }

  void addTask(FoodTaskModel data) async {
    Map<String, dynamic> row = {
      'master': data.master,
      'date': data.date,
      'volume': data.volume
    };
    final id = await dbHelper.insert(row, 'food_task');
    data.id = id;
    _tasks.add(data);
    notifyListeners();
  }

  void removeTask(int target) async {
    _tasks.remove(_tasks.firstWhere((master) => master.id == target));
    await dbHelper.delete(target, 'food_task');
    notifyListeners();
  }
}

class FoodTaskEditModel extends ChangeNotifier {
  int _id = 0;
  int _master = 0;
  String _date = '';
  int _volume = 0;

  FoodTaskModel getEditingTask() {
    return FoodTaskModel(_id, _master, _date, _volume);
  }

  setTaskEditModel(FoodTaskModel data) {
    _id = data.id;
    _master = data.master;
    _date = data.date;
    _volume = data.volume;
  }

  void changeMaster(int? value) {
    if (value != null) {
      _master = value;
    }
    notifyListeners();
  }

  void changeVolume(double value) {
    _volume = value.toInt();
    notifyListeners();
  }
}
