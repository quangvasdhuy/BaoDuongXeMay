import 'dart:convert' as convert;
import 'dart:convert';
import 'package:baoduongxe_app/model/history.dart';
import 'package:baoduongxe_app/model/vehicle.dart';
import 'package:baoduongxe_app/ui/detail_vehicle.dart';
import 'package:baoduongxe_app/ui/detailnau.dart';
import 'package:baoduongxe_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'accessaries_vehicle.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {

  var my_vehicles;

  String? kM_Current = "";
  var accessaries = [];
  var temp = [];
  List<History> histories = [];

  Future getData(String api) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        accessaries = jsonResponse;
      });
    }
  }

  Future getData2(String api) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //print(jsonResponse);

      setState(() {
        for(var data in jsonResponse){
          histories.add(History(
              idHistory: data['idHistory'],
              idDetailNau: data['idDetailNAU'],
              idDeatil: data['idDeatil'],
              repairDate: data['repairDate'],
              totalCost: data['totalCost'],
              kmAccumulation: data['km_accumulation']
          ));
        }
      });
    }
  }

  @override
  void initState() {
    getData("/Accessary");
    getData2("/History");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //print(histories);
    //print(histories[0].kmAccumulation);
    return Scaffold(
      // backgroundColor: Color(0xff1e1e1e),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        title: const Text('My Vehicles'),
        //leading: PopupMenuWidget(),
      ),
      body: FutureBuilder(
        future: BaseClient().getPosts('/DetailVehicle_User'),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            if (snapshot.data?.length == 0) {
              return const Center(
                child: Text("No posts available !"),
              );
            }

          return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context,index){
                  var acc_list = accessaries.toList();
                  //List<History> his_list = histories.toList();

                  my_vehicles = x_vehicles.firstWhere((e) => e["vehicleID"] == snapshot.data?[index]['vehicleID']);
                  var detail_myvehicles = {
                    "idDeatil": snapshot.data?[index]['idDeatil'],
                    "vehicleID": snapshot.data?[index]['vehicleID'],
                    "userID": snapshot.data?[index]['userID'],
                    "kM_Current": snapshot.data?[index]['kM_Current'],
                    "kM_Old": snapshot.data?[index]['kM_Old'],
                  };
                  var detail_Naus = x_detailNAUs.where((e) => e["vehicleID"] == detail_myvehicles["vehicleID"]);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          //snapshot.data?[index]['image']
                          my_vehicles['image']
                      ),
                    ),
                    title: Text(my_vehicles["vehicleName"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text("Số km hiện tại:  ${snapshot.data?[index]['kM_Current'].toString()}", style: const TextStyle(color: Colors.grey),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccessariesVehicle(detail_myvehicles, my_vehicles,detail_Naus,acc_list,histories)));
                    },
                    trailing: Container(
                      width: 70,
                      child: Row(
                        children: [
                          Expanded(child: IconButton(
                            icon: Icon(Icons.edit, color: Colors.white,),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                          content: Form(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      labelText: "Số Km của xe:"
                                                  ),
                                                  onChanged: (value){
                                                    kM_Current = value;
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
                                                            "idDeatil": snapshot.data?[index]['idDeatil'],
                                                            "vehicleID": snapshot.data?[index]['vehicleID'],
                                                            "userID": snapshot.data?[index]['userID'],
                                                            "kM_Old": snapshot.data?[index]['kM_Current'],

                                                            "kM_Current": kM_Current,
                                                          };
                                                          String res = await BaseClient().editPost(data,'/DetailVehicle_User/${ snapshot.data?[index]['idDeatil'] }');
                                                          res == "success"
                                                              ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                                                              : Fluttertoast.showToast(msg: "Error Editing Post !");
                                                          Navigator.of(context).pop();
                                                          setState(() {

                                                          });
                                                        },
                                                        child: const Text("Update")
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        setState(() {});
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
                          )),
                          Expanded(child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white,),
                            onPressed: () async {
                              Map<String, dynamic> data = {
                                "idDeatil": snapshot.data?[index]['idDeatil'],
                                "vehicleID": snapshot.data?[index]['vehicleID'],
                                "userID": snapshot.data?[index]['userID'],
                                "kM_Current": kM_Current,
                              };
                              String res = await BaseClient().deletePost(data,'/DetailVehicle_User/${ snapshot.data?[index]['idDeatil'] }');
                              res == "success"
                                  ? Fluttertoast.showToast(msg: "Post Deleted Successfully !")
                                  : Fluttertoast.showToast(msg: "Error Deleting Post !");
                              setState(() {

                              });
                            },
                          ))
                        ],
                      ),
                    ),
                  );
                }
            );
          } else if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
