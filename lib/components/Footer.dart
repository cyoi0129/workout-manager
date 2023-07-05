import 'package:flutter/material.dart';

class Footer extends StatefulWidget implements PreferredSizeWidget {
  const Footer({super.key, required this.current});
  final int current;
  @override
  State<Footer> createState() => _FooterState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FooterState extends State<Footer> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    var tabs = [
      '/summary',
      '/history',
      '/task',
      '/master',
      '/account',
    ];
    setState(() {
      _selectedIndex = index;
      // Navigator.pushNamed(
      //   context,
      //   tabs[index],
      //   arguments: (index == 0 || index == 4) ? 'refresh' : '',
      // );
      Navigator.of(context)
          .pushNamedAndRemoveUntil(tabs[index], (route) => false);
    });
  }

  Widget build(BuildContext context) {
    setState(() {
      if (widget.current < 5) {
        _selectedIndex = widget.current;
      }
    });
    return BottomNavigationBar(
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.black45,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'サマリー',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: '履歴',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'ノート',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'マスター',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'ユーザー',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
