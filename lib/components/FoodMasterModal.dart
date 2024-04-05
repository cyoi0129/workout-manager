import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../features/FoodMasterData.dart';

class FoodMasterModal extends StatelessWidget {
  int target;
  FoodMasterModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final FoodMasterData _masterData = context.watch<FoodMasterData>();
    final FoodMasterEditModel _currentData =
        context.watch<FoodMasterEditModel>();
    final formatter = NumberFormat("#,###");
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
        height: 400.0,
        width: 360.0,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "食品名",
                  ),
                  controller: _currentData.nameEditingController,
                  onChanged: (text) {
                    _currentData.changeName(text);
                  },
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "食品種別",
                  ),
                  controller: _currentData.typeEditingController,
                  onChanged: (text) {
                    _currentData.changeType(text);
                  },
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('タンパク質(g): '),
                      SizedBox(
                          width: 60,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _currentData.proteinEditingController,
                            onChanged: (value) =>
                                _currentData.changeProtein(int.parse(value)),
                          ))
                    ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('糖質(g): '),
                      SizedBox(
                          width: 60,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _currentData.sugarEditingController,
                            onChanged: (value) =>
                                _currentData.changeSugar(int.parse(value)),
                          ))
                    ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('脂質(g): '),
                      SizedBox(
                          width: 60,
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _currentData.fatEditingController,
                            onChanged: (value) =>
                                _currentData.changeFat(int.parse(value)),
                          ))
                    ])),
            Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                child: Text(
                    'カロリー(kcal): ${formatter.format(_currentData.getEditingMaster().calorie)}')),
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
                    child: const Text('追加')),
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
                      child: const Text('削除')))
            ],
    );
  }
}
