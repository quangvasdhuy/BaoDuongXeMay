import 'dart:convert' as convert;
import 'dart:convert';
import 'package:baoduongxe_app/main.dart';
import 'package:baoduongxe_app/model/history.dart';
import 'package:baoduongxe_app/model/vehicle.dart';
import 'package:baoduongxe_app/ui/detail_vehicle.dart';
import 'package:baoduongxe_app/ui/detailnau.dart';
import 'package:baoduongxe_app/ui/home.dart';
import 'package:baoduongxe_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:baoduongxe_app/services/local_notification_service.dart';
import 'accessaries_vehicle.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyVehicles extends StatefulWidget {
  const MyVehicles({Key? key}) : super(key: key);

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {

  var my_vehicles;

  int? kM_Current = 0;
  var accessaries = [];
  var temp = [];
  var detail_Vehicles = [];
  var list_NAUs = [];
  var list_Vehicles = [];
  List<History> histories = [];
  int kmhieu = 0;
  int kmhh = 0;
  int dem = 0;

  Future getData(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        accessaries = jsonResponse;
      });
    }
  }

  Future getData2(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
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

  Future<void> getData3() async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + "/DetailVehicle_User"));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        detail_Vehicles = jsonResponse;
      });
    }
  }

  Future getData4(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        list_NAUs = jsonResponse;

      });
    }
  }

  Future getData5(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        list_Vehicles = jsonResponse;
      });
    }
  }

  Future getDatax() async {
      setState(() {
        getData2("/History");
        getData("/Accessary");
        getData3();
        getData4("/DetailNAU");
        getData5("/Vehicles");
      });
  }


  late final LocalNotificationService service;

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => MyApp()))
      );
    }
  }

  @override
  void initState() {
    //getData("/Accessary");
    //getData2("/History");
    //getData3();
    // getData4("/DetailNAU");
    // getData5("/Vehicles");
    getDatax();
    super.initState();
    //localNotificationService.intialize(flutterLocalNotificationsPlugin);
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();

  }


  @override
  Widget build(BuildContext context) {
    var list_detailVehicles = detail_Vehicles.where((e) => e["userID"] == getUser["userID"]).toList();
    //print(histories);
    //print(histories[0].kmAccumulation);
    // var alist = detail_Vehicles.toList();
    // if (alist.isNotEmpty) {
    //   for (var x in alist) {
    //     if (x["userID"] == getUser["userID"]) {
    //       y = detail_Vehicles.firstWhere((e) => e["idDeatil"] == x['idDeatil']
    //           && e["userID"] == getUser["userID"]);
    //       print(y);
    //       my_vehicles = x_vehicles.firstWhere((e) => e["vehicleID"] == y["vehicleID"]);
    //       print(my_vehicles);
    //     }else{
    //       print("reject");
    //     }
    //   }
    // }
    return Scaffold(
      // backgroundColor: Color(0xff1e1e1e),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        title: const Text('My Vehicles'),
        //leading: PopupMenuWidget(),
      ),
      body: RefreshIndicator(
        onRefresh: getDatax,
        child: ListView.builder(
            itemCount: list_detailVehicles.length,
            itemBuilder: (context,index){
              //my_Vehicles = list_Vehicles.firstWhere((e) => e[""])

              var a_vehicle = list_Vehicles.firstWhere((e) => e["vehicleID"] == list_detailVehicles[index]["vehicleID"]);
              if (list_detailVehicles == [] || list_detailVehicles.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (list_detailVehicles.isEmpty) {
                  return const Center(
                    child: Text("No posts available !",style: TextStyle(color: Colors.grey),),
                  );
                }
                var acc_list = accessaries.toList();
                var detail_myvehicles = {
                  "idDeatil": list_detailVehicles[index]['idDeatil'],
                  "vehicleID": list_detailVehicles[index]['vehicleID'],
                  "userID": list_detailVehicles[index]['userID'],
                  "kM_Current": list_detailVehicles[index]['kM_Current'],
                  "kM_Old": list_detailVehicles[index]['kM_Old'],
                };
                //kmhieu = detail_myvehicles["kM_Current"] - detail_myvehicles["kM_Old"];
                //print(kmhieu);
                var detail_Naus = list_NAUs.where((e) => e["vehicleID"] == detail_myvehicles["vehicleID"]).toList();

                List<History> histories_list = histories.where((e) => e.idDeatil == list_detailVehicles[index]["idDeatil"]).toList();


                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      a_vehicle["image"].toString(),
                    ),
                  ),
                  title: Text(a_vehicle["vehicleName"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  subtitle: Text("Số km hiện tại:  ${list_detailVehicles[index]['kM_Current'].toString()}", style: const TextStyle(color: Colors.grey),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            AccessariesVehicle(detail_myvehicles,
                                a_vehicle ,
                                detail_Naus,
                                acc_list,
                                histories,
                                kmhh
                            )));
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
                                                  kM_Current = int.tryParse(value);
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
                                                        kmhieu = ((kM_Current! - list_detailVehicles[index]['kM_Current']) as int?)!;
                                                        print(kmhieu);

                                                        Map<String, dynamic> data = {
                                                          "idDeatil": list_detailVehicles[index]['idDeatil'],
                                                          "vehicleID": list_detailVehicles[index]['vehicleID'],
                                                          "userID": list_detailVehicles[index]['userID'],
                                                          "kM_Old": list_detailVehicles[index]['kM_Current'],
                                                          "kM_Current": kM_Current,
                                                        };
                                                        String res = await BaseClient().editPost(data,'/DetailVehicle_User/${ list_detailVehicles[index]['idDeatil'] }');
                                                        res == "success"
                                                            ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                                                            : Fluttertoast.showToast(msg: "Error Editing Post !");

                                                        for(int i =0; i < detail_Naus.length; i++){

                                                          List<History> f_KmAccNaus = histories_list.where((e) => e.idDetailNau == detail_Naus[i]["idDetailNAU"]).toList();

                                                          if (f_KmAccNaus.isEmpty) {
                                                            Map<String, dynamic> data = {
                                                              "idDetailNAU": detail_Naus[i]["idDetailNAU"].toString(),
                                                              "idDeatil": detail_myvehicles["idDeatil"].toString(),
                                                              "km_accumulation": (kmhieu).toString(),
                                                              "totalCost": 0,
                                                            };

                                                            String res = await BaseClient().createPost(data,'/History');
                                                            res == "success"
                                                                ? print("Is empty and create Successfully* !")
                                                                : print("Error Add Post* !");

                                                          }else{
                                                            dynamic f_History = f_KmAccNaus.first;


                                                            Map<String, dynamic> datafirst = {
                                                              "idHistory": f_History.idHistory.toString(),
                                                              "idDetailNAU": detail_Naus[i]["idDetailNAU"].toString(),
                                                              "idDeatil": detail_myvehicles["idDeatil"].toString(),
                                                              "km_accumulation": (f_History.kmAccumulation + kmhieu).toString(),
                                                              //"repairDate": f_History.repairDate.toString(),
                                                              "totalCost": 0
                                                            };
                                                            //print(datafirst);
                                                            String ress = await BaseClient().editPost(datafirst,'/History/${f_History.idHistory}');
                                                            ress == "success"
                                                                ? print("Is edit first data Successfully* !")
                                                                : print("Error Edit Post* !");
                                                          }

                                                          var max = f_KmAccNaus.first;
                                                          //print(max);
                                                          var km_min;
                                                          if (detail_Naus[i]["km_Min"]-(max.kmAccumulation! + kmhieu) > 0) {
                                                            km_min = detail_Naus[i]["km_Min"]-(max.kmAccumulation! + kmhieu);
                                                          }else {
                                                            print("Result $i: ${detail_Naus[i]["km_Min"]-(max.kmAccumulation! + kmhieu)}");
                                                            km_min = 0;
                                                            dem++;
                                                          }
                                                          var km_max;
                                                          if (detail_Naus[i]["km_Max"]-(max.kmAccumulation! + kmhieu) > 0) {
                                                            km_max = detail_Naus[i]["km_Max"]-(max.kmAccumulation! + kmhieu);
                                                          }else {
                                                            km_max = 0;
                                                          }
                                                        }
                                                        setState(() async {
                                                          print("dem: $dem");
                                                          if (dem != 0) {
                                                          await service.showNotification(
                                                          id: 0,
                                                          title: 'Thông báo bảo dưỡng xe',
                                                          body: 'Bạn đang có $dem phụ tùng cần bảo dưỡng');
                                                          dem = 0;
                                                          }
                                                        });
                                                        Navigator.of(context).pop();

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
                              "idDeatil": list_detailVehicles[index]['idDeatil'],
                              "vehicleID": list_detailVehicles[index]['vehicleID'],
                              "userID": list_detailVehicles[index]['userID'],
                              "kM_Current": kM_Current,
                            };
                            String res = await BaseClient().deletePost(data,'/DetailVehicle_User/${ list_detailVehicles[index]['idDeatil'] }');
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

            }),
      ),
      // body: FutureBuilder(
      //   future: BaseClient().getPosts('/DetailVehicle_User'),
      //   builder: (context,snapshot){
      //     if (snapshot.hasData) {
      //       if (snapshot.data?.length == 0) {
      //         return const Center(
      //           child: Text("No posts available !"),
      //         );
      //       }
      //
      //     return ListView.builder(
      //           itemCount: snapshot.data?.length,
      //           itemBuilder: (context,index){
      //             var acc_list = accessaries.toList();
      //             //List<History> his_list = histories.toList();
      //             my_vehicles = x_vehicles.firstWhere((e) => e["vehicleID"] == snapshot.data?[index]["vehicleID"]);
      //
      //             if (my_vehicles != null) {
      //               var detail_myvehicles = {
      //                 "idDeatil": snapshot.data?[index]['idDeatil'],
      //                 "vehicleID": snapshot.data?[index]['vehicleID'],
      //                 "userID": snapshot.data?[index]['userID'],
      //                 "kM_Current": snapshot.data?[index]['kM_Current'],
      //                 "kM_Old": snapshot.data?[index]['kM_Old'],
      //               };
      //               var detail_Naus = x_detailNAUs.where((e) => e["vehicleID"] == detail_myvehicles["vehicleID"]);
      //               return ListTile(
      //                 leading: CircleAvatar(
      //                   backgroundImage: NetworkImage(
      //                     //snapshot.data?[index]['image']
      //                       my_vehicles['image']
      //                   ),
      //                 ),
      //                 title: Text(my_vehicles["vehicleName"], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      //                 subtitle: Text("Số km hiện tại:  ${snapshot.data?[index]['kM_Current'].toString()}", style: const TextStyle(color: Colors.grey),),
      //                 onTap: (){
      //                   Navigator.push(context, MaterialPageRoute(builder: (context) => AccessariesVehicle(detail_myvehicles, my_vehicles,detail_Naus,acc_list,histories)));
      //                 },
      //                 trailing: Container(
      //                   width: 70,
      //                   child: Row(
      //                     children: [
      //                       Expanded(child: IconButton(
      //                         icon: Icon(Icons.edit, color: Colors.white,),
      //                         onPressed: () {
      //                           showDialog(
      //                               barrierDismissible: false,
      //                               context: context,
      //                               builder: (context) =>
      //                                   AlertDialog(
      //                                       content: Form(
      //                                         child: Column(
      //                                           mainAxisSize: MainAxisSize.min,
      //                                           children: [
      //                                             TextFormField(
      //                                               decoration: InputDecoration(
      //                                                   filled: true,
      //                                                   fillColor: Colors.grey[200],
      //                                                   labelText: "Số Km của xe:"
      //                                               ),
      //                                               onChanged: (value){
      //                                                 kM_Current = value;
      //                                               },
      //                                             ),
      //                                             const SizedBox(
      //                                               height: 12,
      //                                             ),
      //                                             Row(
      //                                               mainAxisAlignment: MainAxisAlignment.end,
      //                                               children: [
      //                                                 TextButton(
      //                                                     onPressed: () async {
      //                                                       Map<String, dynamic> data = {
      //                                                         "idDeatil": snapshot.data?[index]['idDeatil'],
      //                                                         "vehicleID": snapshot.data?[index]['vehicleID'],
      //                                                         "userID": snapshot.data?[index]['userID'],
      //                                                         "kM_Old": snapshot.data?[index]['kM_Current'],
      //
      //                                                         "kM_Current": kM_Current,
      //                                                       };
      //                                                       String res = await BaseClient().editPost(data,'/DetailVehicle_User/${ snapshot.data?[index]['idDeatil'] }');
      //                                                       res == "success"
      //                                                           ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
      //                                                           : Fluttertoast.showToast(msg: "Error Editing Post !");
      //                                                       Navigator.of(context).pop();
      //                                                       setState(() {
      //
      //                                                       });
      //                                                     },
      //                                                     child: const Text("Update")
      //                                                 ),
      //                                                 TextButton(
      //                                                   onPressed: () {
      //                                                     Navigator.of(context).pop();
      //                                                     setState(() {});
      //                                                   },
      //                                                   child: const Text("Cancel", style: TextStyle(color: Colors.red),),
      //                                                 )
      //                                               ],
      //                                             )
      //                                           ],
      //                                         ),
      //                                       )
      //                                   )
      //                           );
      //                         },
      //                       )),
      //                       Expanded(child: IconButton(
      //                         icon: const Icon(Icons.delete, color: Colors.white,),
      //                         onPressed: () async {
      //                           Map<String, dynamic> data = {
      //                             "idDeatil": snapshot.data?[index]['idDeatil'],
      //                             "vehicleID": snapshot.data?[index]['vehicleID'],
      //                             "userID": snapshot.data?[index]['userID'],
      //                             "kM_Current": kM_Current,
      //                           };
      //                           String res = await BaseClient().deletePost(data,'/DetailVehicle_User/${ snapshot.data?[index]['idDeatil'] }');
      //                           res == "success"
      //                               ? Fluttertoast.showToast(msg: "Post Deleted Successfully !")
      //                               : Fluttertoast.showToast(msg: "Error Deleting Post !");
      //                           setState(() {
      //
      //                           });
      //                         },
      //                       ))
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }else {
      //               return const Center(child: Text("Your vehicles is empty", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),));
      //             }
      //           }
      //       );
      //     } else if (snapshot.hasError){
      //       return Center(
      //         child: Text(snapshot.error.toString()),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
