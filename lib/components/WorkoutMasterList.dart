import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/WorkoutMasterData.dart';
import 'WorkoutMasterModal.dart';

class WorkoutMasterList extends StatelessWidget {
  const WorkoutMasterList({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkoutMasterData _masterData = context.watch<WorkoutMasterData>();
    final WorkoutMasterEditModel _targetData =
        context.watch<WorkoutMasterEditModel>();

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
                                    return WorkoutMasterModal(
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
                              _masterData.getMasterList()[index].part,
                              style: const TextStyle(
                                  color: Colors.black45, fontSize: 12.0),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.fitness_center, size: 16.0),
                            Text(' ${_masterData.getMasterList()[index].type}'),
                          ],
                        )));
              }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (_) {
                  _targetData
                      .setMasterEditModel(WorkoutMasterModel(0, '', '', ''));
                  return WorkoutMasterModal(target: 0);
                });
          }),
    );
  }
}
