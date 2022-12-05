import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:baoduongxe_app/services/base_client.dart';
import 'package:baoduongxe_app/ui/constants.dart';
import 'package:baoduongxe_app/ui/home.dart';
import 'package:baoduongxe_app/ui/login.dart';
import 'package:baoduongxe_app/ui/widgets/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //theme: ThemeProvider.of(context),
            theme: ThemeData.dark(),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {

  String userName = getUser["name"];
  String userEmail = getUser["email"];
  String userImage = getUser["image"].toString();
  var Users = [];

  Future getData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + '/Users'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
        Users = jsonResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Users.isNotEmpty) {
      getUser = Users.firstWhere((e) => e["username"] == userNamecon.toString());
    }
    //ScreenUtil.init(context, designSize: ScreenUtil.defaultSize, splitScreenMode: false, minTextAdapt: false);
    //ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    ScreenUtil.init(
      context,
      designSize: const Size(414, 896),
      minTextAdapt: true,
    );

    var profileInfo = Expanded(
      child:Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 9.6,
            width: kSpacingUnit.w * 9.6,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 4.6,
                  // backgroundImage: const AssetImage('assets/images/avatar.png'),
                  backgroundImage: NetworkImage(getUser["image"].toString()),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: IconButton(
                        onPressed: (){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      //backgroundColor: kLightPrimaryColor,
                                        content: Form(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.black45,
                                                    labelText: "Name: ",
                                                    hintText: getUser["name"].toString(),
                                                    floatingLabelStyle: const TextStyle(color: Colors.cyan),
                                                    hintStyle: const TextStyle(color: Colors.grey),
                                                ),
                                                onChanged: (value){
                                                  userName = value;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.black45,
                                                    labelText: "Email: ",
                                                    hintText: getUser["email"].toString(),
                                                  floatingLabelStyle: const TextStyle(color: Colors.cyan),
                                                  hintStyle: const TextStyle(color: Colors.grey),
                                                ),
                                                onChanged: (value){
                                                  userEmail = value;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextFormField(
                                                decoration: const InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.black45,
                                                    labelText: "Image: ",
                                                    hintText: "image url",
                                                  floatingLabelStyle: TextStyle(color: Colors.cyan),
                                                  hintStyle: TextStyle(color: Colors.grey),
                                                ),
                                                onChanged: (value){
                                                  userImage = value;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        Map<String, dynamic> data = {
                                                          "name" : userName.toString(),
                                                          "username" : getUser["username"].toString(),
                                                          "email" : userEmail.toString(),
                                                          "password": getUser["password"].toString(),
                                                          "image" : userImage.toString(),
                                                        };
                                                        String res = await BaseClient().editPost(data, '/Users/${getUser["userID"]}');
                                                        res == "success"
                                                            ? Fluttertoast.showToast(msg: "Post Edit Successfully !")
                                                            : Fluttertoast.showToast(msg: "Error Edit Post !");
                                                        Navigator.of(context).pop();
                                                        // setState(() {
                                                        //
                                                        // });
                                                      },
                                                      child: const Text("Add")
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      //setState(() {});
                                                    },
                                                    child: const Text("Cancel", style: TextStyle(color: Colors.red),),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    )
                            );
                        },
                        color: kDarkPrimaryColor,
                        iconSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            getUser["name"],
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            getUser["email"],
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                'Upgrade to PRO',
                style: kButtonTextStyle,
              ),
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState:
          ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
            child: Icon(
              Icons.nights_stay_outlined,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () =>
                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
            child: Icon(
              Icons.light_mode_outlined,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 2),
        Icon(
          Icons.arrow_back_outlined,
          size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 2),
      ],
    );

    return RefreshIndicator(
      onRefresh: getData,
      child: ThemeSwitchingArea(
        child: Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 2.6),
                  header,
                  Expanded(
                    child: ListView(
                      children: const <Widget>[
                        ProfileListItem(
                          icon: Icons.privacy_tip_outlined,
                          text: 'Privacy',
                        ),
                        ProfileListItem(
                          icon: Icons.history_outlined,
                          text: 'Purchase History',
                        ),
                        ProfileListItem(
                          icon: Icons.question_answer_outlined,
                          text: 'Help & Support',
                        ),
                        ProfileListItem(
                          icon: Icons.settings,
                          text: 'Settings',
                        ),
                        ProfileListItem(
                          icon: Icons.people_alt_outlined,
                          text: 'Invite a Friend',
                        ),
                        ProfileListItem(
                          icon: Icons.logout_outlined,
                          text: 'Logout',
                          hasNavigation: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

