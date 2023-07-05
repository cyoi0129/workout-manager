import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:workout_manager/components/WeightModal.dart';
import '../features/FoodMasterData.dart';
import '../features/FoodTaskData.dart';
import '../features/HistoryData.dart';
import 'FoodTaskModal.dart';

class FoodTaskList extends HookWidget {
  const FoodTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodMasterData _masterData = context.watch<FoodMasterData>();
    final FoodTaskData _taskData = context.watch<FoodTaskData>();
    final FoodTaskEditModel _targetData = context.watch<FoodTaskEditModel>();
    final HistoryData _historyData = context.watch<HistoryData>();
    final HistoryEditModel _currentData = context.watch<HistoryEditModel>();
    final formatter = NumberFormat("#,###");
    HistoryModel _currentHistoryData = _historyData.getHistoryData();

    final snackBar = SnackBar(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      margin: const EdgeInsetsDirectional.all(16),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.teal,
            ),
            Text(
              '保存しました',
              style: TextStyle(color: Colors.teal),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 4.0,
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      dismissDirection: DismissDirection.horizontal,
    );

    void _setCurrentData() {
      _currentData.setHistoryEditModel(HistoryModel(
          _historyData.getHistoryData().id,
          _historyData.getHistoryData().date,
          _historyData.getHistoryData().weight,
          _taskData.getTotalCalorie(_masterData)));
    }

    void _changeDate() async {
      final DateTime? picked = await showDatePicker(
          locale: const Locale("en"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(Duration(days: 360)));
      if (picked != null) {
        String dateStr = DateFormat('yyyy-MM-dd').format(picked);
        _taskData.changeDate(dateStr);
        _historyData.changeDate(dateStr);
      }
    }

    useEffect(() {
      _currentData.setHistoryEditModel(_currentHistoryData);
    }, [_currentHistoryData]);

    void _doUpdate() {
      HistoryModel _tempData = HistoryModel(
          _historyData.getHistoryData().id,
          _historyData.getHistoryData().date,
          _currentData.getEditingHistory().weight,
          _taskData.getTotalCalorie(_masterData));
      if (_historyData.getHistoryData().id == 0) {
        _historyData.addHistory(_tempData);
      } else {
        _historyData.updateHistory(_tempData);
      }
    }

    void _showSnack() {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(children: [
                      const Text('日付 '),
                      OutlinedButton(
                        onPressed: () => _changeDate(),
                        child: Text(_taskData.current_date,
                            style: const TextStyle(color: Colors.black)),
                      ),
                    ]),
                  ),
                  SizedBox(
                    child: Row(children: [
                      const Text('体重 '),
                      SizedBox(
                          width: 60,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _currentData.weightEditingController,
                            onChanged: (value) =>
                                _currentData.changeWeight(int.parse(value)),
                          ))
                    ]),
                  ),
                  // SizedBox(
                  //   child: Row(children: [
                  //     Text('体重: ${_historyData.getHistoryData().weight} kg '),
                  //     IconButton(
                  //       icon: const Icon(Icons.edit, size: 20.0),
                  //       onPressed: () {
                  //         showDialog<void>(
                  //             context: context,
                  //             builder: (_) {
                  //               _setCurrentData();
                  //               return WeightModal(
                  //                   target: _historyData.getHistoryData().id);
                  //             });
                  //       },
                  //     ),
                  //   ]),
                  // ),
                ])),
        const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_taskData.current_date}の食事'),
                  Text(
                      '${formatter.format(_taskData.getTotalCalorie(_masterData))} kcal'),
                ])),
        (_taskData.getTaskList().isEmpty)
            ? const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                child: Center(
                  child: Text('データがありません'),
                ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _taskData.getTaskList().length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                          onTap: () => {
                                showDialog<void>(
                                    context: context,
                                    builder: (_) {
                                      _targetData.setTaskEditModel(
                                          _taskData.getTaskList()[index]);
                                      return FoodTaskModal(
                                          target: _taskData
                                              .getTaskList()[index]
                                              .id);
                                    })
                              },
                          title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_masterData
                                      .getMasterItem(
                                          _taskData.getTaskList()[index].master)
                                      .name),
                                  Text(_taskData.getTaskList()[index].date),
                                ],
                              )),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.bolt, size: 16.0),
                              Text(
                                  ' ${_masterData.getMasterItem(_taskData.getTaskList()[index].master).protein * _taskData.getTaskList()[index].volume / 100}'),
                              const Icon(Icons.icecream, size: 16.0),
                              Text(
                                  ' ${_masterData.getMasterItem(_taskData.getTaskList()[index].master).sugar * _taskData.getTaskList()[index].volume / 100}'),
                              const Icon(Icons.egg, size: 16.0),
                              Text(
                                  ' ${_masterData.getMasterItem(_taskData.getTaskList()[index].master).fat * _taskData.getTaskList()[index].volume / 100}'),
                              const Icon(Icons.whatshot, size: 16.0),
                              Text(
                                  ' ${formatter.format(_masterData.getMasterItem(_taskData.getTaskList()[index].master).calorie * _taskData.getTaskList()[index].volume / 100)}'),
                            ],
                          )));
                }),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () {
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          _targetData.setTaskEditModel(
                              FoodTaskModel(0, 1, _taskData.current_date, 0));
                          return FoodTaskModal(target: 0);
                        });
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(120, 40),
                    alignment: Alignment.center,
                  ),
                  child: const Text("追加")),
            ]))
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            _doUpdate();
            Timer(const Duration(seconds: 1), () => _showSnack());
          }),
    );
  }
}
