import 'package:flutter/material.dart';
import '../components/Footer.dart';
import '../components/Calendar.dart';
import '../components/Record.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

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
              Tab(text: '履歴'),
              Tab(text: '自己ベスト'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Calendar(),
            ),
            Center(
              child: Record(),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(current: 1),
      ),
    );
  }
}
