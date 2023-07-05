import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../components/Footer.dart';
import '../features/SummaryData.dart';

class SummaryView extends HookWidget {
  const SummaryView({super.key});
  @override
  Widget build(BuildContext context) {
    final SummaryData _summaryData = context.watch<SummaryData>();
    final CurrentChartData _currentData = context.watch<CurrentChartData>();
    SummaryModel _currentSummaryData = _summaryData.getSummary();

    void updateChart() {
      _currentData.setCurrentChartData(_currentSummaryData);
    }

    useEffect(() {
      updateChart();
    }, [_currentSummaryData]);

    void _changeStartDate() async {
      final DateTime? picked = await showDatePicker(
          locale: const Locale("en"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null) {
        _summaryData.changeDate('start', picked);
        updateChart();
      }
    }

    void _changeEndDate() async {
      final DateTime? picked = await showDatePicker(
          locale: const Locale("en"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 360)));
      if (picked != null) {
        _summaryData.changeDate('end', picked);
        updateChart();
      }
    }

    String dateStr(DateTime date) {
      return DateFormat('yyyy-MM-dd').format(date);
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: SizedBox(
            width: 32,
            height: 31.5,
            child:
                Image.asset('assets/images/header.png', fit: BoxFit.contain)),
        title: const Text('まっちょノート'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/account', (route) => false);
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Text('食事レポート',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0))),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () => _changeStartDate(),
                    child: Text(dateStr(_summaryData.getSummary().start),
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const Text('-'),
                  OutlinedButton(
                    onPressed: () => _changeEndDate(),
                    child: Text(dateStr(_summaryData.getSummary().end),
                        style: const TextStyle(color: Colors.black)),
                  )
                ])),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SfCartesianChart(
                        title: ChartTitle(text: '体重推移'),
                        legend: const Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<ChartData, String>(
                              name: '体重',
                              color: Colors.lightBlueAccent,
                              dataSource: _currentData
                                  .getCurrentChartData()
                                  .weightChartLine,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true)),
                          ColumnSeries<ChartData, String>(
                            dataSource: _currentData
                                .getCurrentChartData()
                                .calorieChartLine,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: 'カロリー',
                            color: Colors.orangeAccent,
                            width: 0.2,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                        ])))),
        Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SfCartesianChart(
                        title: ChartTitle(text: '栄養素'),
                        legend: const Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        primaryXAxis: CategoryAxis(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                            dataSource: _currentData
                                .getCurrentChartData()
                                .proteinChartLine,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: 'タンパク質',
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            width: 0.2,
                            color: Colors.greenAccent,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: _currentData
                                .getCurrentChartData()
                                .sugarChartLine,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: '糖質',
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            width: 0.2,
                            color: Colors.redAccent,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                          ColumnSeries<ChartData, String>(
                            dataSource: _currentData
                                .getCurrentChartData()
                                .sugarChartLine,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                            name: '脂質',
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            width: 0.2,
                            color: Colors.purpleAccent,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                          ),
                        ]))))
      ])),
      bottomNavigationBar: const Footer(current: 0),
    );
  }
}
