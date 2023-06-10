import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'views/Account.dart';
import 'views/Calendar.dart';
import 'views/Master.dart';
import 'views/Task.dart';
import 'features/MasterData.dart';
import 'features/TaskData.dart';
import 'features/InitData.dart';
import 'features/CalendarData.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MasterData()),
        ChangeNotifierProvider(create: (context) => MasterEditModel()),
        ChangeNotifierProvider(create: (context) => TaskData()),
        ChangeNotifierProvider(create: (context) => TaskEditModel()),
        ChangeNotifierProvider(create: (context) => CalendarModel()),
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
          primarySwatch: Colors.lightBlue,
          fontFamily: 'NotoSansJP',
        ),
        routes: {
          '/': (context) => const AccountView(),
          '/calendar': (context) => const CalendarView(),
          '/master': (context) => const MasterView(),
          '/task': (context) => const TaskView(),
        });
  }
}
