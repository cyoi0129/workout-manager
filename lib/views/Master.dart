import 'package:flutter/material.dart';
import '../components/Footer.dart';
import '../components/WorkoutMasterList.dart';
import '../components/FoodMasterList.dart';

class MasterView extends StatelessWidget {
  const MasterView({super.key});

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
              child: WorkoutMasterList(),
            ),
            Center(
              child: FoodMasterList(),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(current: 3),
      ),
    );
  }
}
