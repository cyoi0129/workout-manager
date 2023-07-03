import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../features/FoodMasterData.dart';
import '../features/FoodTaskData.dart';

class FoodTaskModal extends StatelessWidget {
  int target;
  FoodTaskModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final FoodTaskData _taskData = context.watch<FoodTaskData>();
    final FoodMasterData _masterData = context.watch<FoodMasterData>();
    final FoodTaskEditModel _currentData = context.watch<FoodTaskEditModel>();
    final formatter = NumberFormat("#,###");

    void _doAdd() {
      _taskData.addTask(_currentData.getEditingTask());
    }

    void _doUpdate() {
      _taskData.updateTask(_currentData.getEditingTask());
    }

    void _doRemove() {
      _taskData.removeTask(_currentData.getEditingTask().id);
    }

    return AlertDialog(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ]),
      content: SizedBox(
        height: 300.0,
        width: 360.0,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(
                    children: [
                      DropdownButton(
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
                        items: _masterData.getMasterList().map((master) {
                          return DropdownMenuItem<int>(
                            value: master.id,
                            child: Text(master.name),
                          );
                        }).toList(),
                        onChanged: (value) => _currentData.changeMaster(value),
                        value: _currentData.getEditingTask().master,
                      )
                    ],
                  )
                ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('ボリューム: '),
                      Text('${_currentData.getEditingTask().volume.toInt()} %')
                    ])),
            Row(
              children: [
                SizedBox(
                  width: 240.0,
                  child: Slider(
                    key: null,
                    min: 0,
                    max: 300,
                    divisions: 50,
                    onChanged: _currentData.changeVolume,
                    value: _currentData.getEditingTask().volume.toDouble(),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Icon(Icons.bolt, size: 16.0),
                  Text(
                      ' ${_masterData.getMasterItem(_currentData.getEditingTask().master).protein * _currentData.getEditingTask().volume / 100}'),
                  const Icon(Icons.icecream, size: 16.0),
                  Text(
                      ' ${_masterData.getMasterItem(_currentData.getEditingTask().master).sugar * _currentData.getEditingTask().volume / 100}'),
                  const Icon(Icons.egg, size: 16.0),
                  Text(
                      ' ${_masterData.getMasterItem(_currentData.getEditingTask().master).fat * _currentData.getEditingTask().volume / 100}'),
                  const Icon(Icons.whatshot, size: 16.0),
                  Text(
                      ' ${formatter.format(_masterData.getMasterItem(_currentData.getEditingTask().master).calorie * _currentData.getEditingTask().volume / 100)}'),
                ])),
          ],
        ),
      ),
      actions: target == 0
          ? [
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doAdd();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(120, 40),
                      alignment: Alignment.center,
                    ),
                    child: const Text('追加')),
              ),
              GestureDetector(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white70,
                        textStyle: const TextStyle(fontSize: 16),
                        foregroundColor: Colors.black45,
                        fixedSize: const Size(120, 40),
                        alignment: Alignment.center,
                      ),
                      child: const Text('キャンセル')))
            ]
          : [
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doUpdate();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(120, 40),
                      alignment: Alignment.center,
                    ),
                    child: const Text("保存")),
              ),
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doRemove();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(120, 40),
                      alignment: Alignment.center,
                    ),
                    child: const Text("削除")),
              ),
            ],
    );
  }
}
