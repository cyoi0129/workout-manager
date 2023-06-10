import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key, required this.title});
  final String title;
  @override
  State<Header> createState() => _HeaderState();
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('${widget.title}'),
    );
  }
}
