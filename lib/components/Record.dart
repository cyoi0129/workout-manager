import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/WorkoutMasterData.dart';
import '../features/WorkoutTaskData.dart';

class Record extends StatelessWidget {
  const Record({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkoutMasterData _masterData = context.watch<WorkoutMasterData>();
    final WorkoutTaskData _taskData = context.watch<WorkoutTaskData>();
    _taskData.setGetAllTask();

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
            child: Center(
              child: Text('過去の最大記録'),
            )),
        (_taskData.getMaxData().isEmpty)
            ? const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                child: Center(
                  child: Text('データがありません'),
                ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _taskData.getMaxData().length,
                itemBuilder: (BuildContext context, int index) {
                  return _masterData
                          .hasWeight(_taskData.getMaxData()[index].master)
                      ? ListTile(
                          title: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.military_tech,
                                        size: 20.0,
                                        color: Colors.redAccent,
                                      ),
                                      Text(_masterData
                                          .getMasterItem(_taskData
                                              .getMaxData()[index]
                                              .master)
                                          .name),
                                    ],
                                  ),
                                  Text(
                                      '${_taskData.getMaxData()[index].weight} kg'),
                                ],
                              )),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.calendar_month, size: 16.0),
                                  Text(_taskData.getMaxData()[index].date)
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.workspaces, size: 16.0),
                                  Text('${_taskData.getMaxData()[index].sets}')
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.replay_10, size: 16.0),
                                  Text('${_taskData.getMaxData()[index].rep}')
                                ]),
                              )
                            ],
                          ))
                      : null;
                }),
      ]),
    );
  }
}
