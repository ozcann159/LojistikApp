import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loadspotter/Pages/cargo_postings.dart';
import 'package:loadspotter/Pages/home_page.dart';
import 'package:loadspotter/Pages/profile.dart';
import 'package:loadspotter/Pages/status.dart';
import 'package:loadspotter/Pages/vehicles.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({Key? key}) : super(key: key);

  @override
  _BottomnavState createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomePage homepage;
  late Vehicles vehicles;
  late Status status;
  late Profile profile;

  @override
  void initState() {
    super.initState();
    homepage = HomePage();
    vehicles = Vehicles();
    status = Status();
    profile = Profile();
    pages = [homepage, vehicles, status, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.green,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.tab_sharp, color: Colors.white),
          Icon(Icons.fire_truck_sharp, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
