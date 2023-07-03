import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'DatabaseHelper.dart';

class AccountModel {
  String gender;
  int age;
  int height;
  int weight;
  AccountModel(this.gender, this.age, this.height, this.weight);
}

class BaseModel {
  int protein;
  int sugar;
  int fat;
  int calorie;
  BaseModel(this.protein, this.sugar, this.fat, this.calorie);
}

class AccountData extends ChangeNotifier {
  AccountModel _account = AccountModel('男', 0, 0, 0);
  final dbHelper = DatabaseHelper.instance;

  AccountData() {
    fetchAccountData();
  }

  Future fetchAccountData() async {
    final response = await _getDBData();
    _account = response
        .map((item) => AccountModel(
            item['gender'], item['age'], item['height'], item['weight']))
        .toList()[0];
    notifyListeners();
  }

  AccountModel getAccountData() {
    return _account;
  }

  Future<List<Map<String, dynamic>>> _getDBData() async {
    final allRows = await dbHelper.queryAllRows('account_info');
    return allRows;
  }

  void updateAccount(AccountModel data) async {
    Map<String, dynamic> row = {
      'id': 1,
      'gender': data.gender,
      'age': data.age,
      'height': data.height,
      'weight': data.weight,
    };
    await dbHelper.update(row, 'account_info');
    notifyListeners();
  }
}

class AccountEditModel extends ChangeNotifier {
  String _gender = '男';
  int _age = 0;
  int _height = 0;
  int _weight = 0;
  int _protein = 0;
  int _sugar = 0;
  int _fat = 0;
  int _calorie = 0;

  AccountModel getEditingAccount() {
    return AccountModel(_gender, _age, _height, _weight);
  }

  BaseModel getBaseData() {
    return BaseModel(_protein, _sugar, _fat, _calorie);
  }

  setAccountEditModel(AccountModel data) {
    _gender = data.gender;
    _age = data.age;
    _height = data.height;
    _weight = data.weight;
    ageEditingController = TextEditingController(text: data.age.toString());
    heightEditingController =
        TextEditingController(text: data.height.toString());
    weightEditingController =
        TextEditingController(text: data.weight.toString());
  }

  TextEditingController ageEditingController = TextEditingController();
  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();

  void changeGender(String? value) {
    if (value != null) {
      _gender = value;
    }
    calcBaseData();
    notifyListeners();
  }

  void changeAge(int? value) {
    if (value != null) {
      _age = value;
    }
    calcBaseData();
    notifyListeners();
  }

  void changeHeight(int? value) {
    if (value != null) {
      _height = value;
    }
    calcBaseData();
    notifyListeners();
  }

  void changeWeight(int? value) {
    if (value != null) {
      _weight = value;
    }
    calcBaseData();
    notifyListeners();
  }

  void calcBaseData() {
    // 糖質 4kcal 脂質 9kcal タンパク質 4kcal
    _protein = _weight * 2;
    _sugar = 120;
    if (_gender == '男') {
      _calorie =
          (13.397 * _weight + 4.799 * _height - 5.677 * _age + 88.362).toInt();
    } else {
      _calorie =
          (9.247 * _weight + 3.098 * _height - 4.33 * _age + 447.593).toInt();
    }
    _fat = (_calorie - _protein * 4 - _sugar * 4) ~/ 9.toInt();
  }

  @override
  void dispose() {
    ageEditingController.dispose();
    heightEditingController.dispose();
    weightEditingController.dispose();
    super.dispose();
  }
}
