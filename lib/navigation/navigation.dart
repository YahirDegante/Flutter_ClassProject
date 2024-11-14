import 'package:flutter/material.dart';
import 'package:learning_2_10c/modules/posts/presentation/posts.dart';
import 'package:learning_2_10c/navigation/home.dart';
import 'package:learning_2_10c/navigation/map_sample.dart';
import 'package:learning_2_10c/navigation/profile.dart';
import 'package:learning_2_10c/navigation/reservations.dart';
import 'package:learning_2_10c/navigation/top.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigation extends StatefulWidget {
  final bool nextButton;

  const Navigation({super.key, required this.nextButton});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  late final SharedPreferences prefs;

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Top(),
    Reservations(),
    Profile(),
    MapSample(),
    Lista(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outlined),
            label: 'Top 5',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_outlined),
            label: 'Reservaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_off_outlined),
            label: 'Perfil',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.map_outlined),
          //   label: 'Mapa',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Lista',
          )
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _checkTutorial();
  }

  Future<void> _checkTutorial() async {
    if (!widget.nextButton) {
      prefs = await SharedPreferences.getInstance();
      final bool? tutorial = prefs.getBool('tutorial');
      if (tutorial == null) {
        Navigator.pushReplacementNamed(context, '/tutorial');
      }
    }
  }
}
