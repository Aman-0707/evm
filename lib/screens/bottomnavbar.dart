import 'package:flutter/material.dart';
import 'package:simple_floating_bottom_nav_bar/floating_bottom_nav_bar.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';
import '../screens/ProfileScreen.dart';
import '../screens/eventlistscreen.dart';
import '../screens/mainpage.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBar();
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    EventFinderScreen(),
    EventListPage(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: FloatingBottomNavBar(
        pages: pages,
        items: const [
          FloatingBottomNavItem(
            inactiveIcon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          FloatingBottomNavItem(
            inactiveIcon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
          ),
          FloatingBottomNavItem(
            inactiveIcon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person),
          ),
        ],
        initialPageIndex: 0,
        backgroundColor: Colors.blueGrey,
        bottomPadding: 0,
        elevation: 0,
        radius: 20,
        width: 250,
        height: 45,
      ),
    );
  }
}
