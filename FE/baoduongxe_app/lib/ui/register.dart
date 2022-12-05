import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user.dart';
import '../services/base_client.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
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
                            controller: nameController,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{2,}$');
                              if(value!.isEmpty){
                                return ("Họ không được để trống!");
                              }
                              if(!regex.hasMatch(value)){
                                return ("Họ của bạn không đúng (Tối thiểu. 2 kí tự)");
                              }
                              return null;
                            },
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
                                hintText: "Name",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                            height: 10,
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
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            style: const TextStyle(color: Colors.white),

                            validator: (value) {
                              if (value?.length == null || value?.length == 0) return "Password can't be empty";
                              if (value!.length < 6) return "Password lenght must have >=6";
                              return null;
                            },
                            obscureText: vis,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      vis = !vis;
                                    });
                                  },
                                ),
                                helperText: "Password length should have >=6",
                                helperStyle: TextStyle(
                                  fontSize: 14,
                                ),
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
                                hintText: "Password",
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
                                'Sign Up =>',
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

                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: const Text("Register ?"),
                                          actions: [
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: const Text("NO",style: TextStyle(color: Colors.red),)),
                                            TextButton(onPressed: () async{
                                              //Navigator.pushNamed(context, 'login');
                                              var user = User(
                                                  name: nameController.text.toString(),
                                                  username: usernameController.text.toString(),
                                                  email: emailController.text.toString(),
                                                  password: passwordController.text.toString(),
                                                  image: "https://www.pinpng.com/pngs/m/53-531868_person-icon-png-transparent-png.png"
                                              );
                                              //print(user);
                                              var response = await BaseClient()
                                                  .post('/Users', user)
                                                  .catchError((err) {});
                                              //print(response);
                                              response != null
                                                  ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                                                  : Fluttertoast.showToast(msg: "Error Editing Post !");
                                              Navigator.pop(context);
                                            }, child: const Text("YES"))
                                          ],
                                        );
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
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

  // checkUser() async {
  //   if (usernameController.text.length == 0) {
  //     setState(() {
  //       // circular = false;
  //       validate = false;
  //       errorText = "Username Can't be empty";
  //     });
  //   } else {
  //     var response = await networkHandler
  //         .get("/user/checkUsername/${usernameController.text}");
  //     if (response['Status']) {
  //       setState(() {
  //         // circular = false;
  //         validate = false;
  //         errorText = "Username already taken";
  //       });
  //     } else {
  //       setState(() {
  //         // circular = false;
  //         validate = true;
  //       });
  //     }
  //   }
  // }

  Widget usernameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Username"),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value?.length == null || value?.length == 0) return "Email can't be empty";
              if (value!.contains("@")) return "Email is Invalid";
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Password"),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value?.length == null || value?.length == 0) return "Password can't be empty";
              if (value!.length < 6) return "Password lenght must have >=6";
              return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize: 14,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
