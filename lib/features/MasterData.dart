import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';

class MasterModel {
  int id;
  String name;
  String part;
  String type;
  MasterModel(this.id, this.name, this.part, this.type);
}

class MasterData extends ChangeNotifier {
  List<MasterModel> _masters = [];
  final dbHelper = DatabaseHelper.instance;

  MasterData() {
    fetchMasterData();
  }

  Future fetchMasterData() async {
    final response = await _getDBData();
    _masters = (response as List<dynamic>)
        .map((item) =>
            MasterModel(item['id'], item['name'], item['part'], item['type']))
        .toList();
    notifyListeners();
  }

  List<MasterModel> getMasterList() {
    return _masters;
  }

  MasterModel getMasterItem(int target) {
    return _masters.firstWhere((master) => master.id == target);
  }

  bool hasWeight(int target) {
    return _masters.firstWhere((master) => master.id == target).type != '自重';
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('master_table');
    return allRows;
  }

  void updateMaster(MasterModel data) async {
    _masters.firstWhere((master) => master.id == data.id).name = data.name;
    _masters.firstWhere((master) => master.id == data.id).part = data.part;
    _masters.firstWhere((master) => master.id == data.id).type = data.type;
    Map<String, dynamic> row = {
      'id': data.id,
      'name': data.name,
      'part': data.part,
      'type': data.type,
    };
    await dbHelper.update(row, 'master_table');
    notifyListeners();
  }

  void addMaster(MasterModel data) async {
    Map<String, dynamic> row = {
      'name': data.name,
      'part': data.part,
      'type': data.type,
    };
    final id = await dbHelper.insert(row, 'master_table');
    data.id = id;
    _masters.add(data);
    notifyListeners();
  }

  void removeMaster(int target) async {
    _masters.remove(_masters.firstWhere((master) => master.id == target));
    // final id = await dbHelper.queryRowCount('master_table');
    // final rowsDeleted = await dbHelper.delete(id!, 'master_table');
    await dbHelper.delete(target, 'master_table');
    await dbHelper.deleteRows(target, 'task_table', 'master');
    notifyListeners();
  }
}

class MasterEditModel extends ChangeNotifier {
  int _id = 0;
  String _name = '';
  String _part = '';
  String _type = '';

  MasterModel getEditingMaster() {
    return MasterModel(_id, _name, _part, _type);
  }

  setMasterEditModel(MasterModel data) {
    _id = data.id;
    _name = data.name;
    _part = data.part;
    _type = data.type;
    nameEditTextEditingController = TextEditingController(text: data.name);
  }

  TextEditingController nameEditTextEditingController = TextEditingController();

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
    nameEditTextEditingController.dispose();
    super.dispose();
  }
}
