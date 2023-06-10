import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../components/Header.dart';
import '../components/Footer.dart';
import '../features/MasterData.dart';
import '../features/TaskData.dart';
import '../components/TaskModal.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final MasterData _masterData = context.watch<MasterData>();
    final TaskData _taskData = context.watch<TaskData>();
    final TaskEditModel _targetData = context.watch<TaskEditModel>();
    // String current_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // _taskData.changeDate(current_date);
    void _changeDate() async {
      final DateTime? picked = await showDatePicker(
          locale: const Locale("en"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(Duration(days: 360)));
      if (picked != null) {
        String dateStr = DateFormat('yyyy-MM-dd').format(picked);
        _taskData.changeDate(dateStr);
      }
    }

    return Scaffold(
      appBar: const Header(title: 'トレーニング'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('日付'),
                  OutlinedButton(
                    onPressed: () => _changeDate(),
                    child: Text('${_taskData.current_date}',
                        style: TextStyle(color: Colors.black)),
                  )
                ])),
        (_taskData == null || _taskData.getTaskList().length == 0)
            ? Padding(
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
                                      return TaskModal(
                                          target: _taskData
                                              .getTaskList()[index]
                                              .id);
                                    })
                              },
                          title: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${_masterData.getMasterItem(_taskData.getTaskList()[index].master).name}'),
                                  Text(
                                      '${_taskData.getTaskList()[index].date}'),
                                ],
                              )),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.fitness_center, size: 16.0),
                                  Text(_masterData.hasWeight(
                                          _taskData.getTaskList()[index].master)
                                      ? '${_taskData.getTaskList()[index].weight} kg'
                                      : '-')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.workspaces, size: 16.0),
                                  Text('${_taskData.getTaskList()[index].sets}')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.replay_10, size: 16.0),
                                  Text('${_taskData.getTaskList()[index].rep}')
                                ]),
                              )
                            ],
                          )));
                }),
      ]),
      floatingActionButton: FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => {
                showDialog<void>(
                    context: context,
                    builder: (_) {
                      _targetData.setTaskEditModel(TaskModel(
                          0, 1, '${_taskData.current_date}', 0, 0, 0));
                      return TaskModal(target: 0);
                    })
              }),
      bottomNavigationBar: Footer(current: 1),
    );
  }
}
