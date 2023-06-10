import 'package:flutter/material.dart';

class Footer extends StatefulWidget implements PreferredSizeWidget {
  const Footer({super.key, required this.current});
  final int current;
  @override
  State<Footer> createState() => _FooterState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FooterState extends State<Footer> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    var tabs = ['/calendar', '/task', '/master', '/'];
    setState(() {
      _selectedIndex = index;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(tabs[index], (route) => false);
    });
  }

  Widget build(BuildContext context) {
    setState(() {
      _selectedIndex = widget.current;
    });
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.lightBlue,
          icon: Icon(Icons.calendar_month),
          label: 'カレンダー',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.lightBlue,
          icon: Icon(Icons.history),
          label: 'トレーニング',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.lightBlue,
          icon: Icon(Icons.fitness_center),
          label: 'メニュー',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.lightBlue,
          icon: Icon(Icons.person),
          label: 'アカウント',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
