import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user.dart';
import '../services/base_client.dart';

class MyForgot extends StatefulWidget {
  const MyForgot({Key? key}) : super(key: key);

  @override
  _MyForgotState createState() => _MyForgotState();
}

class _MyForgotState extends State<MyForgot> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String errorText ="";
  bool vis = true;
  bool validate = false;
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              //errorText: validate ? null : errorText,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "User Name",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            // validator: (value)=> value != null && !EmailValidator.validate(value)
                            // ? "Enter correct email!" : null,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                )),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Comfirm =>',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.cyanAccent.shade400,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      Fluttertoast.showToast(msg: "Your password has been reset !");
                                      // showDialog(context: context, builder: (context){
                                      //   return AlertDialog(
                                      //     title: const Text("Register ?"),
                                      //     actions: [
                                      //       TextButton(onPressed: (){
                                      //         Navigator.pop(context);
                                      //       }, child: const Text("NO",style: TextStyle(color: Colors.red),)),
                                      //       TextButton(onPressed: () async{
                                      //         //Navigator.pushNamed(context, 'login');
                                      //         var user = User(
                                      //             name: nameController.text.toString(),
                                      //             username: usernameController.text.toString(),
                                      //             email: emailController.text.toString(),
                                      //             password: passwordController.text.toString(),
                                      //             image: "https://www.pinpng.com/pngs/m/53-531868_person-icon-png-transparent-png.png"
                                      //         );
                                      //         String data = await BaseClient()
                                      //             .post('/Users', user)
                                      //             .catchError((err) {});
                                      //         data == "success"
                                      //             ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                                      //             : Fluttertoast.showToast(msg: "Error Editing Post !");
                                      //         Navigator.pop(context);
                                      //       }, child: const Text("YES"))
                                      //     ],
                                      //   );
                                      Navigator.of(context).pop();
                                      },
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
