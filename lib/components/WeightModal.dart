import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../features/HistoryData.dart';

class WeightModal extends StatelessWidget {
  int target;
  WeightModal({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    final HistoryData _historyData = context.watch<HistoryData>();
    final HistoryEditModel _currentData = context.watch<HistoryEditModel>();
    final formatter = NumberFormat("#,###");

    void _doUpdate() {
      if (_currentData.getEditingHistory().id == 0) {
        _historyData.addHistory(_currentData.getEditingHistory());
      } else {
        _historyData.updateHistory(_currentData.getEditingHistory());
      }
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
          height: 200.0,
          width: 360.0,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('体重(kg): '),
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
                      ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
                  child: Text(
                      'カロリー(kcal): ${formatter.format(_currentData.getEditingHistory().calorie)}')),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
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
              child: const Text('保存'))
        ]);
  }
}
