import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget{
  const PopupMenuWidget({super.key});

 @override
 Widget build(BuildContext context){
  return PopupMenuButton(
      color: Colors.black,
      shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(7),
      ),
      icon: const Icon(Icons.menu),
      itemBuilder: (context) => [
       // PopupMenuItem(
       //  value: 1,
       //  child: TextButton(
       //      child: const Text(
       //       'Home',
       //       style: TextStyle(
       //        color: Colors.white,
       //       ),
       //      ),
       //      onPressed: () {
       //       Navigator.pushNamed(context, 'home');
       //      }),
       // ),
       // PopupMenuItem(
       //  value: 2,
       //  child: TextButton(
       //      child: const Text(
       //       'About',
       //       style: TextStyle(color: Colors.white),
       //      ),
       //      onPressed: () {
       //       Navigator.pushNamed(context, 'about');
       //      }),
       // ),
       PopupMenuItem(
        value: 3,
        child: TextButton(
            child: const Text(
             'Log out',
             style: TextStyle(
              color: Colors.white,
             ),
            ),
            onPressed: () {
             Navigator.pushNamed(context, 'login');
            }),
       ),
      ]);
 }
}

