import 'package:flutter/material.dart';

import 'package:phase_2_implementation/categories_screen/categories_screen.dart';
import 'package:phase_2_implementation/home_screen/home_screen.dart';
import 'package:phase_2_implementation/settings_screen/settings_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();

  static _MainNavigationState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainNavigationState>();
}

class _MainNavigationState extends State<MainNavigation> {
  var currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];
  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
      ),
    );
  }
}
