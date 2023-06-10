import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/Header.dart';
import '../components/Footer.dart';
import '../features/MasterData.dart';
import '../features/TaskData.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final MasterData _masterData = context.watch<MasterData>();
    final TaskData _taskData = context.watch<TaskData>();
    _taskData.setGetAllTask();

    return Scaffold(
      appBar: const Header(title: 'アカウント'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
            child: Center(
              child: Text('過去の最大記録'),
            )),
        (_taskData == null || _taskData.getMaxData().length == 0)
            ? Padding(
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
                              padding: EdgeInsets.fromLTRB(0, 16.0, 0, 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.military_tech,
                                        size: 20.0,
                                        color: Colors.lightBlue,
                                      ),
                                      Text(
                                          '${_masterData.getMasterItem(_taskData.getMaxData()[index].master).name}'),
                                    ],
                                  ),
                                  Text(
                                      '${_taskData.getMaxData()[index].weight} kg'),
                                ],
                              )),
                          subtitle: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.calendar_month, size: 16.0),
                                  Text('${_taskData.getMaxData()[index].date}')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.workspaces, size: 16.0),
                                  Text('${_taskData.getMaxData()[index].sets}')
                                ]),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                                child: Row(children: [
                                  Icon(Icons.replay_10, size: 16.0),
                                  Text('${_taskData.getMaxData()[index].rep}')
                                ]),
                              )
                            ],
                          ))
                      : null;
                }),
      ]),
      bottomNavigationBar: Footer(current: 3),
    );
  }
}
