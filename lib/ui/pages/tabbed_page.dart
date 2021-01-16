import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef WidgetFactory = Widget Function();

class TabbedPage extends StatefulWidget {
  final List<WidgetFactory> pages;
  final List<BottomNavigationBarItem> items;

  TabbedPage({this.pages, this.items})
      : assert(pages.length == items.length),
        assert(pages.length > 1);
  @override
  State<TabbedPage> createState() => TabbedPageState();
}

class TabbedPageState extends State<TabbedPage> {
  int _tabIndex = 0;

  void onTap(int index) => setState(() {
        _tabIndex = index;
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabIndex,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xFF101010),
          items: widget.items,
          onTap: onTap,
        ),
        body: widget.pages[_tabIndex](),
      );
}
