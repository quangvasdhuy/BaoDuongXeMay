import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavigationBarr extends StatelessWidget {
  const BottomNavigationBarr({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    late PageController _pageController;


    // return Container(
    //   color: Colors.black,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
    //     child: GNav(
    //       backgroundColor: Colors.black,
    //       color: Colors.white,
    //       activeColor: Colors.white,
    //       tabBackgroundColor: Colors.grey.shade900,
    //       gap: 8,
    //
    //       padding: const EdgeInsets.all(6),
    //       tabs: const [
    //         GButton(icon: Icons.home,
    //           text: 'Home',
    //
    //         ),
    //         GButton(icon: FontAwesomeIcons.car,
    //           text: 'Vehicles',
    //         ),
    //         GButton(icon: Icons.person,
    //           text: 'Profile',
    //         ),
    //         GButton(icon: Icons.settings,
    //           text: 'Settings',
    //         ),
    //       ],
    //       onTabChange: (index) {
    //         print(index);
    //         switch(index) {
    //           case 0: Navigator.pushNamed(context, 'home');  break;
    //           case 1: Navigator.pushNamed(context, 'vehicles');  break;
    //           case 2: Navigator.pushNamed(context, 'home'); break;
    //           case 3: Navigator.pushNamed(context, 'home'); break;
    //           default: return;
    //         }
    //       },
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.heart,
                text: 'Likes',
              ),
              GButton(
                icon: LineIcons.search,
                text: 'Search',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              // setState(() {_selectedIndex = index;}
              switch(index) {
                case 0: Navigator.pushNamed(context, 'home'); break;
                case 1: Navigator.pushNamed(context, 'vehicles'); break;
                default: return;
              }
            },
          ),
        ),
      ),
    );
  }
}