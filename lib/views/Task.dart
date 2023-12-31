import 'package:flutter/material.dart';
import '../components/Footer.dart';
import '../components/WorkoutTaskList.dart';
import '../components/FoodTaskList.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'トレーニング'),
              Tab(text: '食事'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: WorkoutTaskList(),
            ),
            Center(
              child: FoodTaskList(),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(current: 2),
      ),
    );
  }
}
