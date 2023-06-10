import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/MasterData.dart';
import '../features/TaskData.dart';

class TaskModal extends StatelessWidget {
  int target;
  TaskModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final TaskData _taskData = context.watch<TaskData>();
    final MasterData _masterData = context.watch<MasterData>();
    final TaskEditModel _currentData = context.watch<TaskEditModel>();

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text('トレーニング編集'))],
        )
      ]),
      content: Container(
        height: 360.0,
        width: 360.0,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Row(
                    children: [
                      DropdownButton(
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
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
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('ウェイト')])),
            _masterData.hasWeight(_currentData.getEditingTask().master)
                ? Row(
                    children: [
                      Slider(
                        key: null,
                        min: 0.0,
                        max: 200.0,
                        onChanged: _currentData.changeWeight,
                        value:
                            (_currentData.getEditingTask().weight).toDouble(),
                      ),
                      Text('${(_currentData.getEditingTask().weight).toInt()}')
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [Text('-')])
                        ])),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('セット数')])),
            Row(
              children: [
                Slider(
                  key: null,
                  min: 0.0,
                  max: 5.0,
                  onChanged: _currentData.changeSets,
                  value: _currentData.getEditingTask().sets.toDouble(),
                ),
                Text('${(_currentData.getEditingTask().sets).toInt()}')
              ],
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('回数')])),
            Row(
              children: [
                Slider(
                  key: null,
                  min: 0.0,
                  max: 20.0,
                  onChanged: _currentData.changeRep,
                  value: _currentData.getEditingTask().rep.toDouble(),
                ),
                Text('${(_currentData.getEditingTask().rep).toInt()}')
              ],
            ),
          ],
        ),
      ),
      actions: target == 0
          ? <Widget>[
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doAdd();
                      Navigator.pop(context);
                    },
                    child: Text('追加'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: Size(120, 40),
                      alignment: Alignment.center,
                    )),
              ),
              GestureDetector(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('キャンセル'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        textStyle: const TextStyle(fontSize: 16),
                        foregroundColor: Colors.black12,
                        fixedSize: Size(120, 40),
                        alignment: Alignment.center,
                      )))
            ]
          : <Widget>[
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doUpdate();
                      Navigator.pop(context);
                    },
                    child: Text("保存"),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: Size(120, 40),
                      alignment: Alignment.center,
                    )),
              ),
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doRemove();
                      Navigator.pop(context);
                    },
                    child: Text("削除"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: Size(120, 40),
                      alignment: Alignment.center,
                    )),
              ),
            ],
    );
  }
}
