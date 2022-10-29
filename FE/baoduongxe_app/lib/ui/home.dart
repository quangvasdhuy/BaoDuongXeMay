import 'package:baoduongxe_app/ui/popupmenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../main.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  aboutAchivements(num, type) {
    return Row(
      children: [
        Text(num,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "Soho",
            )),
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: "Soho",
              ),
            ))
      ],
    );
  }

  mySpec(icon, text) {
    return Container(
      height: 115,
      width: 105,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: const Color(0xff252525),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    fontSize: 16, fontFamily: "Soho", color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //bottomNavigationBar: const MyApp(),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: PopupMenuWidget(),
        // leading: PopupMenuButton(
        //     color: Colors.black,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(7),
        //     ),
        //     icon: const Icon(Icons.menu),
        //     itemBuilder: (context) => [
        //       PopupMenuItem(
        //         value: 1,
        //         child: TextButton(
        //             child: const Text(
        //               'Home',
        //               style: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //             onPressed: () {
        //               Navigator.pushNamed(context, 'home');
        //             }),
        //       ),
        //       PopupMenuItem(
        //         value: 2,
        //         child: TextButton(
        //             child: const Text(
        //               'About',
        //               style: TextStyle(color: Colors.white),
        //             ),
        //             onPressed: () {
        //               Navigator.pushNamed(context, 'about');
        //             }),
        //       ),
        //       PopupMenuItem(
        //         value: 3,
        //         child: TextButton(
        //             child: const Text(
        //               'Log out',
        //               style: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //             onPressed: () {
        //               Navigator.pushNamed(context, 'login');
        //             }),
        //       ),
        //     ]),
      ),

      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 50,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.38, 0.7, 1.0],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Container(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 35),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/car.png',
                    height: 400,
                    width: 500,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.49),
                child: Column(
                  children: const [
                    Text('Maintain Reminder',
                        style: TextStyle(
                            fontFamily: "Soho",
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Keep your vehicle alway in the best!',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Soho",
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return Container(
            margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
            height: 500,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      aboutAchivements('2', ' Vehicles'),
                      aboutAchivements('0', ' Maintaining'),
                      aboutAchivements('3', ' Schedules'),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    '  Feature: ',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Soho",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // mySpec(FontAwesomeIcons.car, 'Vehicles'),
                          // mySpec(FontAwesomeIcons.solidRectangleList, 'Accessories'),
                          // mySpec(FontAwesomeIcons.calendarDays, 'Schedules'),
                    Container(
                    height: 115,
                    width: 105,
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      color: const Color(0xff252525),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: (){
                                Navigator.pushNamed(context, 'vehicles');
                              },
                              icon: const Icon(
                                FontAwesomeIcons.car,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Vehicles',
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Soho", color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                          Container(
                            height: 115,
                            width: 105,
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              color: const Color(0xff252525),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      color: Colors.white,
                                      onPressed: (){
                                        //Navigator.pushNamed(context, 'home');
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.star,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Accessories',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: "Soho", color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 115,
                            width: 105,
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              color: const Color(0xff252525),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      color: Colors.white,
                                      onPressed: (){
                                        //Navigator.pushNamed(context, 'home');
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.calendar,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Calendar',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: "Soho", color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     mySpec(FontAwesomeIcons.github, 'GitHub'),
                      //     mySpec(FontAwesomeIcons.linux, 'Linux'),
                      //     mySpec(FontAwesomeIcons.wordpress, 'WordPress'),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     mySpec(FontAwesomeIcons.appStoreIos, 'iOS'),
                      //     mySpec(FontAwesomeIcons.terminal, 'Scripting'),
                      //     mySpec(FontAwesomeIcons.gamepad, 'Game Dev'),
                      //   ],
                      // ),
                    ],
                  )
                ],
              ),
            ),
          );

        },
      ),


    );
  }
}