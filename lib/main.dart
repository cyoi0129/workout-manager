import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'views/History.dart';
import 'views/Master.dart';
import 'views/Summary.dart';
import 'views/Task.dart';
import 'views/Account.dart';
import 'features/WorkoutMasterData.dart';
import 'features/WorkoutTaskData.dart';
import 'features/FoodMasterData.dart';
import 'features/FoodTaskData.dart';
import 'features/InitData.dart';
import 'features/CalendarData.dart';
import 'features/AccountData.dart';
import 'features/HistoryData.dart';
import 'features/SummaryData.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutMasterData()),
        ChangeNotifierProvider(create: (context) => WorkoutMasterEditModel()),
        ChangeNotifierProvider(create: (context) => WorkoutTaskData()),
        ChangeNotifierProvider(create: (context) => WorkoutTaskEditModel()),
        ChangeNotifierProvider(create: (context) => FoodMasterData()),
        ChangeNotifierProvider(create: (context) => FoodMasterEditModel()),
        ChangeNotifierProvider(create: (context) => FoodTaskData()),
        ChangeNotifierProvider(create: (context) => FoodTaskEditModel()),
        ChangeNotifierProvider(create: (context) => CalendarModel()),
        ChangeNotifierProvider(create: (context) => AccountData()),
        ChangeNotifierProvider(create: (context) => AccountEditModel()),
        ChangeNotifierProvider(create: (context) => HistoryData()),
        ChangeNotifierProvider(create: (context) => HistoryEditModel()),
        ChangeNotifierProvider(create: (context) => SummaryData()),
        ChangeNotifierProvider(create: (context) => CurrentChartData()),
      ],
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    InitData();
    return MaterialApp(
        title: 'まっちょノート',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'NotoSansJP',
        ),
        routes: {
          '/': (context) => const HistoryView(),
          '/summary': (context) => const SummaryView(),
          '/history': (context) => const HistoryView(),
          '/task': (context) => const TaskView(),
          '/master': (context) => const MasterView(),
          '/account': (context) => const AccountView(),
        });
  }
}
