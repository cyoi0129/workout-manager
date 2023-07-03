import 'DatabaseHelper.dart';
import 'Util.dart';

class InitData {
  final dbHelper = DatabaseHelper.instance;
  final _initWorkoutMaster = DataPackage().initWorkoutMasterData;
  final _initWorkoutTask = DataPackage().initWorkoutTaskData;
  final _initFoodMaster = DataPackage().initFoodMasterData;
  final _initFoodTask = DataPackage().initFoodTaskData;
  final _initAccountData = DataPackage().initAccountData;
  final _initWeightData = DataPackage().initWeightData;

  void _addInitData(rowData, target) async {
    Map<String, dynamic> row = rowData;
    final id = await dbHelper.insert(row, target);
    print('Init Added ID: $id $row');
  }

  InitData() {
    _initWorkoutMaster.forEach((item) => _addInitData(item, 'workout_master'));
    _initFoodMaster.forEach((item) => _addInitData(item, 'food_master'));
    _initAccountData.forEach((item) => _addInitData(item, 'account_info'));
    // _initWorkoutTask.forEach((item) => _addInitData(item, 'workout_task'));
    // _initFoodTask.forEach((item) => _addInitData(item, 'food_task'));
    // _initWeightData.forEach((item) => _addInitData(item, 'weight_history'));
  }
}
