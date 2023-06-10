import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';
import 'package:intl/intl.dart';
import 'MasterData.dart';

class TaskModel {
  int id;
  int master;
  String date;
  int weight;
  int sets;
  int rep;
  TaskModel(this.id, this.master, this.date, this.weight, this.sets, this.rep);
}

class TaskData extends ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> _all_tasks = [];
  String current_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final dbHelper = DatabaseHelper.instance;

  TaskData() {
    fetchTaskData(current_date);
  }

  changeDate(String date) {
    current_date = date;
    fetchTaskData(date);
    notifyListeners();
  }

  setGetAllTask() async {
    final response = await _getDBData();
    _all_tasks = (response as List<dynamic>)
        .map((item) => TaskModel(item['id'], item['master'], item['date'],
            item['weight'], item['sets'], item['rep']))
        .toList();
    notifyListeners();
  }

  List<TaskModel> getMaxData() {
    Set<int> uniqueIdList = _all_tasks.map((item) => item.master).toSet();
    List<TaskModel> sortedTasks = _all_tasks;
    sortedTasks.sort((a, b) => b.weight.compareTo(a.weight));
    List<TaskModel> uniqueTaskList = uniqueIdList
        .map((item) =>
            _all_tasks.firstWhere((element) => element.master == item))
        .toList();
    return uniqueTaskList;
  }

  Future fetchTaskData(String date) async {
    final response = await _getDBTargetData(date);
    _tasks = (response as List<dynamic>)
        .map((item) => TaskModel(item['id'], item['master'], item['date'],
            item['weight'], item['sets'], item['rep']))
        .toList();
    notifyListeners();
  }

  List<TaskModel> getTaskList() {
    return _tasks;
  }

  List<TaskModel> getAllTaskList() {
    return _all_tasks;
  }

  TaskModel getTaskItem(int target) {
    return _tasks.firstWhere((task) => task.id == target);
  }

  Future<List<Map<String, dynamic>>> _getDBTargetData(String date) async {
    final targetRows =
        await dbHelper.queryTargetRows('task_table', 'date', date);
    return targetRows;
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('task_table');
    return allRows;
  }

  void updateTask(TaskModel data) async {
    _tasks.firstWhere((master) => master.id == data.id).master = data.master;
    _tasks.firstWhere((master) => master.id == data.id).date = data.date;
    _tasks.firstWhere((master) => master.id == data.id).weight = data.weight;
    _tasks.firstWhere((master) => master.id == data.id).sets = data.sets;
    _tasks.firstWhere((master) => master.id == data.id).rep = data.rep;

    Map<String, dynamic> row = {
      'id': data.id,
      'master': data.master,
      'date': data.date,
      'weight': data.weight,
      'sets': data.sets,
      'rep': data.rep,
    };
    await dbHelper.update(row, 'task_table');
    notifyListeners();
  }

  void addTask(TaskModel data) async {
    Map<String, dynamic> row = {
      'master': data.master,
      'date': data.date,
      'weight': data.weight,
      'sets': data.sets,
      'rep': data.rep,
    };
    final id = await dbHelper.insert(row, 'task_table');
    data.id = id;
    _tasks.add(data);
    notifyListeners();
  }

  void removeTask(int target) async {
    _tasks.remove(_tasks.firstWhere((master) => master.id == target));
    await dbHelper.delete(target, 'task_table');
    notifyListeners();
  }
}

class TaskEditModel extends ChangeNotifier {
  int _id = 0;
  int _master = 0;
  String _date = '';
  int _weight = 0;
  int _sets = 0;
  int _rep = 0;

  TaskModel getEditingTask() {
    return TaskModel(_id, _master, _date, _weight, _sets, _rep);
  }

  setTaskEditModel(TaskModel data) {
    _id = data.id;
    _master = data.master;
    _date = data.date;
    _weight = data.weight;
    _sets = data.sets;
    _rep = data.rep;
  }

  void changeMaster(int? value) {
    if (value != null) {
      _master = value;
    }
    notifyListeners();
  }

  void changeWeight(double value) {
    _weight = value.toInt();
    notifyListeners();
  }

  void changeSets(double value) {
    _sets = value.toInt();
    notifyListeners();
  }

  void changeRep(double value) {
    _rep = value.toInt();
    notifyListeners();
  }
}
