import 'package:flutter/material.dart';
import 'package:palomas_test/presentation/screens/history_orders.dart';

import 'new_order_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          const NewOrderScreen(),
          const HistoryOrdersScreen(),
        ].elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:
        const TextStyle(fontFamily: "Destroy", fontSize: 20.0),
        unselectedLabelStyle:
        const TextStyle(fontFamily: "Destroy", fontSize: 18.0),
        elevation: 6.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Создание заказа',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'История заказов',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
