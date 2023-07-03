import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../features/WorkoutMasterData.dart';
import '../features/WorkoutTaskData.dart';
import 'WorkoutTaskModal.dart';

class WorkoutTaskList extends StatelessWidget {
  const WorkoutTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkoutMasterData _masterData = context.watch<WorkoutMasterData>();
    final WorkoutTaskData _taskData = context.watch<WorkoutTaskData>();
    final WorkoutTaskEditModel _targetData =
        context.watch<WorkoutTaskEditModel>();
    void _changeDate() async {
      final DateTime? picked = await showDatePicker(
          locale: const Locale("en"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null) {
        String dateStr = DateFormat('yyyy-MM-dd').format(picked);
        _taskData.changeDate(dateStr);
      }
    }

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('日付'),
                  OutlinedButton(
                    onPressed: () => _changeDate(),
                    child: Text(_taskData.current_date,
                        style: const TextStyle(color: Colors.black)),
                  )
                ])),
        (_taskData.getTaskList().isEmpty)
            ? const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
                child: Center(
                  child: Text('データがありません'),
                ))
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _taskData.getTaskList().length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: ListTile(
                          onTap: () => {
                                showDialog<void>(
                                    context: context,
                                    builder: (_) {
                                      _targetData.setTaskEditModel(
                                          _taskData.getTaskList()[index]);
                                      return WorkoutTaskModal(
                                          target: _taskData
                                              .getTaskList()[index]
                                              .id);
                                    })
                              },
                          title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_masterData
                                      .getMasterItem(
                                          _taskData.getTaskList()[index].master)
                                      .name),
                                  Text(_taskData.getTaskList()[index].date),
                                ],
                              )),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.fitness_center, size: 16.0),
                                  Text(_masterData.hasWeight(
                                          _taskData.getTaskList()[index].master)
                                      ? '${_taskData.getTaskList()[index].weight} kg'
                                      : '-')
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.workspaces, size: 16.0),
                                  Text('${_taskData.getTaskList()[index].sets}')
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  const Icon(Icons.replay_10, size: 16.0),
                                  Text('${_taskData.getTaskList()[index].rep}')
                                ]),
                              )
                            ],
                          )));
                }),
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                showDialog<void>(
                    context: context,
                    builder: (_) {
                      _targetData.setTaskEditModel(WorkoutTaskModel(
                          0, 1, _taskData.current_date, 0, 0, 0));
                      return WorkoutTaskModal(target: 0);
                    })
              }),
    );
  }
}
