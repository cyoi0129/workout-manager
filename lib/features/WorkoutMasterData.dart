import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';

class WorkoutMasterModel {
  int id;
  String name;
  String part;
  String type;
  WorkoutMasterModel(this.id, this.name, this.part, this.type);
}

class WorkoutMasterData extends ChangeNotifier {
  List<WorkoutMasterModel> _masters = [];
  final dbHelper = DatabaseHelper.instance;

  WorkoutMasterData() {
    fetchMasterData();
  }

  Future fetchMasterData() async {
    final response = await _getDBData();
    _masters = response
        .map((item) => WorkoutMasterModel(
            item['id'], item['name'], item['part'], item['type']))
        .toList();
    notifyListeners();
  }

  List<WorkoutMasterModel> getMasterList() {
    return _masters;
  }

  WorkoutMasterModel getMasterItem(int target) {
    return _masters.firstWhere((master) => master.id == target);
  }

  bool hasWeight(int target) {
    return _masters.firstWhere((master) => master.id == target).type != '自重';
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('workout_master');
    return allRows;
  }

  void updateMaster(WorkoutMasterModel data) async {
    _masters.firstWhere((item) => item.id == data.id).name = data.name;
    _masters.firstWhere((item) => item.id == data.id).part = data.part;
    _masters.firstWhere((item) => item.id == data.id).type = data.type;
    Map<String, dynamic> row = {
      'id': data.id,
      'name': data.name,
      'part': data.part,
      'type': data.type,
    };
    await dbHelper.update(row, 'workout_master');
    notifyListeners();
  }

  void addMaster(WorkoutMasterModel data) async {
    Map<String, dynamic> row = {
      'name': data.name,
      'part': data.part,
      'type': data.type,
    };
    final id = await dbHelper.insert(row, 'workout_master');
    data.id = id;
    _masters.add(data);
    notifyListeners();
  }

  void removeMaster(int target) async {
    _masters.remove(_masters.firstWhere((master) => master.id == target));
    await dbHelper.delete(target, 'workout_master');
    await dbHelper.deleteRows(target, 'workout_task', 'master');
    notifyListeners();
  }
}

class WorkoutMasterEditModel extends ChangeNotifier {
  int _id = 0;
  String _name = '';
  String _part = '';
  String _type = '';

  WorkoutMasterModel getEditingMaster() {
    return WorkoutMasterModel(_id, _name, _part, _type);
  }

  setMasterEditModel(WorkoutMasterModel data) {
    _id = data.id;
    _name = data.name;
    _part = data.part;
    _type = data.type;
    nameEditingController = TextEditingController(text: data.name);
  }

  TextEditingController nameEditingController = TextEditingController();

  void changeName(String? value) {
    if (value != null) {
      _name = value;
    }
    notifyListeners();
  }

  void changePart(String? value) {
    if (value != null) {
      _part = value;
    }
    notifyListeners();
  }

  void changeType(String? value) {
    if (value != null) {
      _type = value;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    super.dispose();
  }
}
