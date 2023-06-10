import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/MasterData.dart';

class MasterModal extends StatelessWidget {
  int target;
  MasterModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final MasterData _masterData = context.watch<MasterData>();
    final MasterEditModel _currentData = context.watch<MasterEditModel>();
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
      content: Container(
        height: 300.0,
        width: 360.0,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: TextField(
                  controller: _currentData.nameEditTextEditingController,
                  onChanged: (text) {
                    _currentData.changeName(text);
                  },
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('部位')])),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton(
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      items: [
                        DropdownMenuItem(
                          child: Text('部位選択'),
                          value: '',
                        ),
                        DropdownMenuItem(
                          child: Text('胸筋'),
                          value: '胸筋',
                        ),
                        DropdownMenuItem(
                          child: Text('背筋'),
                          value: '背筋',
                        ),
                        DropdownMenuItem(
                          child: Text('腹筋'),
                          value: '腹筋',
                        ),
                        DropdownMenuItem(
                          child: Text('腕'),
                          value: '腕',
                        ),
                        DropdownMenuItem(
                          child: Text('肩'),
                          value: '肩',
                        ),
                        DropdownMenuItem(
                          child: Text('脚'),
                          value: '脚',
                        ),
                      ],
                      onChanged: (value) =>
                          _currentData.changePart(value.toString()),
                      value: _currentData.getEditingMaster().part,
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('種類')])),
            Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButton(
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      items: [
                        DropdownMenuItem(
                          child: Text('種類選択'),
                          value: '',
                        ),
                        DropdownMenuItem(
                          child: Text('自重'),
                          value: '自重',
                        ),
                        DropdownMenuItem(
                          child: Text('フリーウェイト'),
                          value: 'フリーウェイト',
                        ),
                        DropdownMenuItem(
                          child: Text('マシン'),
                          value: 'マシン',
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
                    child: Text('保存'),
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
                      child: Text('削除'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        textStyle: const TextStyle(fontSize: 16),
                        foregroundColor: Colors.white,
                        fixedSize: Size(120, 40),
                        alignment: Alignment.center,
                      )))
            ],
    );
  }
}
