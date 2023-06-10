import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/MasterData.dart';
import '../components/Header.dart';
import '../components/Footer.dart';
import '../components/MasterModal.dart';

class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) {
    final MasterData _masterData = context.watch<MasterData>();
    final MasterEditModel _targetData = context.watch<MasterEditModel>();

    return Scaffold(
      appBar: const Header(title: 'メニュー'),
      body: (_masterData == null || _masterData.getMasterList().length == 0)
          ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                                    return MasterModal(
                                        target: _masterData
                                            .getMasterList()[index]
                                            .id);
                                  })
                            },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_masterData.getMasterList()[index].name}'),
                            Text(
                              '${_masterData.getMasterList()[index].part}',
                              style: TextStyle(
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
          child: new Icon(Icons.add),
          onPressed: () {
            showDialog<void>(
                context: context,
                builder: (_) {
                  _targetData.setMasterEditModel(MasterModel(0, '', '', ''));
                  return MasterModal(target: 0);
                });
          }),
      bottomNavigationBar: Footer(current: 2),
    );
  }
}
