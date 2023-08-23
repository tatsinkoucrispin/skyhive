import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skyhive/screens/profile_screen.dart';
import 'package:skyhive/screens/search_screen.dart';
import 'package:skyhive/screens/ticket_screen.dart';

import 'home_screen.dart';

class BottomBar extends StatefulWidget {
  int selectedIndex=0;
  String departure;
  String arrival;
  String dates;
  String heure;
  String passengerController;
  String valueChoose;

  BottomBar({super.key,required this.selectedIndex,required this.departure,
    required this.arrival,
    required this.dates,
    required this.heure,
    required this.passengerController,
    required this.valueChoose});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _widgetOptions = <Widget>[
      const HomeScreen(),
      const SearchScreen(),
      TicketScreen(
        departure: widget.departure,
        arrival: widget.arrival,
        dates: widget.dates,
        heure: widget.heure,
        passengerController: widget.passengerController,
        valueChoose: widget.valueChoose,
      ),
      ProfileScreen(
        email: '',
          departure: widget.departure,
          arrival: widget.arrival,
          dates: widget.dates,
          heure: widget.heure
      ),
    ];
  }
  late int _selectedIndex;
  late List<Widget> _widgetOptions;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex =index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child:_widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items:const [
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
              label: "Search"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
              label: "/Ticket"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Profile")
        ],

      ),
    );
  }
}
