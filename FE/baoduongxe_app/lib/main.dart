import 'dart:io';

import 'package:baoduongxe_app/ui/accessaries.dart';
import 'package:baoduongxe_app/ui/accessaries_vehicle.dart';
import 'package:baoduongxe_app/ui/detailnau.dart';
import 'package:baoduongxe_app/ui/forgot_page.dart';
import 'package:baoduongxe_app/ui/my_vehicles.dart';
import 'package:baoduongxe_app/ui/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/register.dart';
import 'ui/login.dart';
import 'ui/vehicles.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyLogin(),
    routes: {
      'register': (context) => const MyRegister(),
      'login': (context) => const MyLogin(),
      'home': (context) => const MyHome(),
      'vehicles': (context) => const Vehicles(),
      'myvehicles': (context) => const MyVehicles(),
      'about': (context) => const MyApp(),
      'accessary': (context) => const MyAccessaries(),
      'detailnau': (context) => const MyDetailNau(),
      'forgot': (context) => const MyForgot(),
      // 'profile': (context) => ProfilePage(),
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  //int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            const MyHome(),
            const MyDetailNau(),
            const MyVehicles(),
            ProfilePage(),
            // Container(
            //   color: Colors.red,
            // )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        animationDuration: const Duration(milliseconds: 456),
        backgroundColor: Colors.black,
        curve: Curves.ease,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: const Text("Home"),
              icon: const Icon(Icons.home),
              inactiveColor: Colors.grey,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: const Text("Vehicles"),
              icon: const Icon(FontAwesomeIcons.car),
              inactiveColor: Colors.grey,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: const Text("My Vehicles"),
              icon: const Icon(Icons.person),
              inactiveColor: Colors.grey,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: const Text("Settings"),
              icon: const Icon(Icons.settings),
              inactiveColor: Colors.grey,
              activeColor: Colors.white),
        ],
      ),
    );
  }
}

  // This widget is the root of your application.
