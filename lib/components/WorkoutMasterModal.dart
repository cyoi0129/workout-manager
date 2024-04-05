import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/WorkoutMasterData.dart';

class WorkoutMasterModal extends StatelessWidget {
  int target;
  WorkoutMasterModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final WorkoutMasterData _masterData = context.watch<WorkoutMasterData>();
    final WorkoutMasterEditModel _currentData =
        context.watch<WorkoutMasterEditModel>();
    void _doAdd() {
      _masterData.addMaster(_currentData.getEditingMaster());
    }

    void _doUpdate() {
      _masterData.updateMaster(_currentData.getEditingMaster());
    }

    void _doRemove() {
      _masterData.removeMaster(_currentData.getEditingMaster().id);
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
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: TextField(
                  controller: _currentData.nameEditingController,
                  onChanged: (text) {
                    _currentData.changeName(text);
                  },
                )),
            const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('部位')])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      items: const [
                        DropdownMenuItem(
                          value: '',
                          child: Text('部位選択'),
                        ),
                        DropdownMenuItem(
                          value: '胸筋',
                          child: Text('胸筋'),
                        ),
                        DropdownMenuItem(
                          value: '背筋',
                          child: Text('背筋'),
                        ),
                        DropdownMenuItem(
                          value: '腹筋',
                          child: Text('腹筋'),
                        ),
                        DropdownMenuItem(
                          value: '腕',
                          child: Text('腕'),
                        ),
                        DropdownMenuItem(
                          value: '肩',
                          child: Text('肩'),
                        ),
                        DropdownMenuItem(
                          value: '脚',
                          child: Text('脚'),
                        ),
                      ],
                      onChanged: (value) =>
                          _currentData.changePart(value.toString()),
                      value: _currentData.getEditingMaster().part,
                    )
                  ],
                )),
            const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('種類')])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton(
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      items: const [
                        DropdownMenuItem(
                          value: '',
                          child: Text('種類選択'),
                        ),
                        DropdownMenuItem(
                          value: '自重',
                          child: Text('自重'),
                        ),
                        DropdownMenuItem(
                          value: 'フリーウェイト',
                          child: Text('フリーウェイト'),
                        ),
                        DropdownMenuItem(
                          value: 'マシン',
                          child: Text('マシン'),
                        ),
                      ],
                      onChanged: (value) =>
                          _currentData.changeType(value.toString()),
                      value: _currentData.getEditingMaster().type,
                    )
                  ],
                )),
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
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 14),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(120, 40),
                    alignment: Alignment.center,
                  ),
                  child: const Text('追加'),
                ),
              ),
              GestureDetector(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white70,
                  textStyle: const TextStyle(fontSize: 14),
                  foregroundColor: Colors.black45,
                  fixedSize: const Size(120, 40),
                  alignment: Alignment.center,
                ),
                child: const Text('キャンセル'),
              ))
            ]
          : [
              GestureDetector(
                child: ElevatedButton(
                    onPressed: () {
                      _doUpdate();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(fontSize: 16),
                      foregroundColor: Colors.white,
                      fixedSize: const Size(120, 40),
                      alignment: Alignment.center,
                    ),
                    child: const Text('保存')),
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
                child: const Text('削除'),
              ))
            ],
    );
  }
}
