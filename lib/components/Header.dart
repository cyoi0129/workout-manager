import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});
  @override
  State<Header> createState() => _HeaderState();
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    /// The height of the toolbar component of the [AppBar].
    const double kToolbarHeight = 56.0;

    /// The height of the bottom navigation bar.
    const double kBottomNavigationBarHeight = 56.0;

    /// The height of a tab bar containing text.
    const double kTextTabBarHeight = kMinInteractiveDimension;
    return AppBar(
      toolbarHeight: kToolbarHeight,
      leadingWidth: 56.0,
      leading: SizedBox(
          width: 32,
          height: 31.5,
          child: Image.asset('assets/images/header.png', fit: BoxFit.contain)),
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
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(kBottomNavigationBarHeight),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            tabs: [
              Tab(text: 'トレーニング'),
              Tab(text: '食事'),
            ],
          ),
        ),
      ),
    );
  }
}
