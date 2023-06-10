import 'DatabaseHelper.dart';
import 'Util.dart';

class InitData {
  final dbHelper = DatabaseHelper.instance;
  final _initMasterData = DataPackage().initMasterData;
  final _initTaskData = DataPackage().initTaskData;

  void _addInitData(rowData, target) async {
    Map<String, dynamic> row = rowData;
    final id = await dbHelper.insert(row, target + '_table');
    print('Init Added ID: $id $row');
  }

  InitData() {
    _initMasterData.forEach((item) => {_addInitData(item, 'master')});
    _initTaskData.forEach((item) => {_addInitData(item, 'task')});
  }
}
