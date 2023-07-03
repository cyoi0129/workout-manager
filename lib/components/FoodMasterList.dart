import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../features/FoodMasterData.dart';
import 'FoodMasterModal.dart';

class FoodMasterList extends StatelessWidget {
  const FoodMasterList({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodMasterData _masterData = context.watch<FoodMasterData>();
    final FoodMasterEditModel _targetData =
        context.watch<FoodMasterEditModel>();
    final formatter = NumberFormat("#,###");

    return Scaffold(
      body: (_masterData.getMasterList().isEmpty)
          ? const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                      child: Center(
                        child: Text('データがありません'),
                      ))
                ])
          : ListView.builder(
              shrinkWrap: true,
              itemCount: _masterData.getMasterList().length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: ListTile(
                        onTap: () => {
                              showDialog<void>(
                                  context: context,
                                  builder: (_) {
                                    _targetData.setMasterEditModel(
                                        _masterData.getMasterList()[index]);
                                    return FoodMasterModal(
                                        target: _masterData
                                            .getMasterList()[index]
                                            .id);
                                  })
                            },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_masterData.getMasterList()[index].name),
                            Text(
                              _masterData.getMasterList()[index].type,
                              style: const TextStyle(
                                  color: Colors.black45, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.bolt, size: 16.0),
                            Text(
                                ' ${_masterData.getMasterList()[index].protein}'),
                            const Icon(Icons.icecream, size: 16.0),
                            Text(
                                ' ${_masterData.getMasterList()[index].sugar}'),
                            const Icon(Icons.egg, size: 16.0),
                            Text(' ${_masterData.getMasterList()[index].fat}'),
                            const Icon(Icons.whatshot, size: 16.0),
                            Text(
                                ' ${formatter.format(_masterData.getMasterList()[index].calorie)}'),
                          ],
                        )));
              }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (_) {
                  _targetData.setMasterEditModel(
                      FoodMasterModel(0, '', '', 0, 0, 0, 0));
                  return FoodMasterModal(target: 0);
                });
          }),
    );
  }
}
