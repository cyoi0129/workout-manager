import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../features/WorkoutMasterData.dart';
import '../features/WorkoutTaskData.dart';

class WorkoutTaskModal extends StatelessWidget {
  int target;
  WorkoutTaskModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final WorkoutTaskData _taskData = context.watch<WorkoutTaskData>();
    final WorkoutMasterData _masterData = context.watch<WorkoutMasterData>();
    final WorkoutTaskEditModel _currentData =
        context.watch<WorkoutTaskEditModel>();

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
        height: 400.0,
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Text('ウェイト(kg): '),
                  Text('${(_currentData.getEditingTask().weight).toInt()}')
                ])),
            _masterData.hasWeight(_currentData.getEditingTask().master)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 8.0, 64.0, 8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _currentData.weightEditingController,
                      onChanged: (value) =>
                          _currentData.changeWeight(int.parse(value)),
                    ))
                : const Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [Text('-')])
                        ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('セット数: '),
                      Text('${(_currentData.getEditingTask().sets).toInt()}')
                    ])),
            Row(
              children: [
                SizedBox(
                  width: 260.0,
                  child: Slider(
                    key: null,
                    min: 0.0,
                    max: 5.0,
                    onChanged: _currentData.changeSets,
                    value: _currentData.getEditingTask().sets.toDouble(),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('回数: '),
                      Text('${(_currentData.getEditingTask().rep).toInt()}')
                    ])),
            Row(
              children: [
                SizedBox(
                  width: 260.0,
                  child: Slider(
                    key: null,
                    min: 0.0,
                    max: 20.0,
                    onChanged: _currentData.changeRep,
                    value: _currentData.getEditingTask().rep.toDouble(),
                  ),
                ),
              ],
            ),
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
                  child: const Text("削除"),
                ),
              ),
            ],
    );
  }
}
