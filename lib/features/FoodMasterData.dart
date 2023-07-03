import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';

class FoodMasterModel {
  int id;
  String name;
  String type;
  int protein;
  int sugar;
  int fat;
  int calorie;
  FoodMasterModel(this.id, this.name, this.type, this.protein, this.sugar,
      this.fat, this.calorie);
}

class FoodMasterData extends ChangeNotifier {
  List<FoodMasterModel> _masters = [];
  final dbHelper = DatabaseHelper.instance;

  FoodMasterData() {
    fetchMasterData();
  }

  Future fetchMasterData() async {
    final response = await _getDBData();
    _masters = response
        .map((item) => FoodMasterModel(item['id'], item['name'], item['type'],
            item['protein'], item['sugar'], item['fat'], item['calorie']))
        .toList();
    notifyListeners();
  }

  List<FoodMasterModel> getMasterList() {
    return _masters;
  }

  FoodMasterModel getMasterItem(int target) {
    return _masters.firstWhere((master) => master.id == target);
  }

  bool hasWeight(int target) {
    return _masters.firstWhere((master) => master.id == target).type != '自重';
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('food_master');
    return allRows;
  }

  void updateMaster(FoodMasterModel data) async {
    _masters.firstWhere((item) => item.id == data.id).name = data.name;
    _masters.firstWhere((item) => item.id == data.id).type = data.type;
    _masters.firstWhere((item) => item.id == data.id).protein = data.protein;
    _masters.firstWhere((item) => item.id == data.id).sugar = data.sugar;
    _masters.firstWhere((item) => item.id == data.id).fat = data.fat;
    _masters.firstWhere((item) => item.id == data.id).calorie = data.calorie;
    Map<String, dynamic> row = {
      'id': data.id,
      'name': data.name,
      'type': data.type,
      'protein': data.protein,
      'sugar': data.sugar,
      'fat': data.fat,
      'calorie': data.calorie
    };
    await dbHelper.update(row, 'food_master');
    notifyListeners();
  }

  void addMaster(FoodMasterModel data) async {
    Map<String, dynamic> row = {
      'name': data.name,
      'type': data.type,
      'protein': data.protein,
      'sugar': data.sugar,
      'fat': data.fat,
      'calorie': data.calorie
    };
    final id = await dbHelper.insert(row, 'food_master');
    data.id = id;
    _masters.add(data);
    notifyListeners();
  }

  void removeMaster(int target) async {
    _masters.remove(_masters.firstWhere((master) => master.id == target));
    await dbHelper.delete(target, 'food_master');
    await dbHelper.deleteRows(target, 'food_task', 'master');
    notifyListeners();
  }
}

class FoodMasterEditModel extends ChangeNotifier {
  int _id = 0;
  String _name = '';
  String _type = '';
  int _protein = 0;
  int _sugar = 0;
  int _fat = 0;
  int _calorie = 0;

  FoodMasterModel getEditingMaster() {
    return FoodMasterModel(_id, _name, _type, _protein, _sugar, _fat, _calorie);
  }

  setMasterEditModel(FoodMasterModel data) {
    _id = data.id;
    _name = data.name;
    _type = data.type;
    _protein = data.protein;
    _sugar = data.sugar;
    _calorie = data.calorie;
    nameEditingController = TextEditingController(text: data.name);
    typeEditingController = TextEditingController(text: data.type);
    proteinEditingController = TextEditingController(text: data.name);
    sugarEditingController = TextEditingController(text: data.name);
    fatEditingController = TextEditingController(text: data.name);
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController typeEditingController = TextEditingController();
  TextEditingController proteinEditingController = TextEditingController();
  TextEditingController sugarEditingController = TextEditingController();
  TextEditingController fatEditingController = TextEditingController();

  void changeName(String? value) {
    if (value != null) {
      _name = value;
    }
    notifyListeners();
  }

  void changeType(String? value) {
    if (value != null) {
      _type = value;
    }
    notifyListeners();
  }

  void changeProtein(int value) {
    _protein = value.toInt();
    _changeCalorie();
    notifyListeners();
  }

  void changeSugar(int value) {
    _sugar = value.toInt();
    _changeCalorie();
    notifyListeners();
  }

  void changeFat(int value) {
    _fat = value.toInt();
    _changeCalorie();
    notifyListeners();
  }

  void _changeCalorie() {
    _calorie = _protein * 4 + _sugar * 4 + _fat * 9;
    notifyListeners();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    typeEditingController.dispose();
    proteinEditingController.dispose();
    sugarEditingController.dispose();
    fatEditingController.dispose();
    super.dispose();
  }
}
