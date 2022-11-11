import 'package:baoduongxe_app/model/accessary.dart';
import 'package:baoduongxe_app/model/history.dart';
import 'package:baoduongxe_app/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

class AccessariesVehicle extends StatelessWidget {

  var detailVehicle_User;
  var my_Vehicles;
  var detail_Naus;
  var my_accessaries;
  var nau_list = [];
  var totalCost;
  List<History> history_list = [];
  int max_km = 0;



  AccessariesVehicle(this.detailVehicle_User,this.my_Vehicles,this.detail_Naus,this.my_accessaries,this.history_list);



  @override
  Widget build(BuildContext context) {
    nau_list = detail_Naus.where((e) => e["vehicleID"] == detailVehicle_User["vehicleID"]).toList();

    return Scaffold(
      // backgroundColor: Color(0xff1e1e1e),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        title: Text("Accessaries of ${my_Vehicles["vehicleName"]}"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: nau_list.length,
            itemBuilder: (context,index){
              int kmthuong = (detailVehicle_User["kM_Current"] - detailVehicle_User["kM_Old"]);


              print(detailVehicle_User["idDeatil"]);
              List<History> km_acc = history_list.where((e) => (e.idDetailNau == nau_list[index]["idDetailNAU"])).toList();
              print(km_acc);

              if (km_acc.isNotEmpty) {
                dynamic max = km_acc.first;
                for (var e in km_acc) {
                  if (e.kmAccumulation! > max.kmAccumulation) max = e;
                }
                print(max.kmAccumulation);
              }


              var km_min;
              if (nau_list[index]["km_Min"]-kmthuong > 0) {
                km_min = nau_list[index]["km_Min"]-kmthuong;
              }else {
                km_min = "nhắc nhở";
              }
              var km_max;
              if (nau_list[index]["km_Max"]-kmthuong > 0) {
                km_max = nau_list[index]["km_Max"]-kmthuong;
              }else {
                km_max = "báo động";
              }


              var my_accessary = my_accessaries.firstWhere((e) => e["accessaryID"] == nau_list[index]["accessaryID"]);
              var x = Accessary(
                accessaryId: my_accessary["accessaryID"],
                accessaryName: my_accessary["accessaryName"],
                image: my_accessary["image"],
              );
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    //tam[index]['image'],
                    x.image.toString(),
                  ),
                ),
                title: Text("${x.accessaryName.toString()} (${nau_list[index]["km_Min"].toString()} - ${nau_list[index]["km_Max"].toString()} Km)", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: Text("Số km chạm mốc: ${km_min} - ${km_max}" , style: const TextStyle(color: Colors.grey),),
                // subtitle: RichText(
                //   text: TextSpan(text: "Số km chạm mốc: ",
                //       style: TextStyle(color: Colors.grey),
                //     children: <TextSpan>[
                //
                //     ]
                //   ),
                // ),
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailNAU(b,tam[index],z)));
                },
                trailing: Container(
                  width: 70,
                  child: Row(
                    children: [
                      Expanded(child: IconButton(
                        icon: Icon(Icons.check, color: Colors.green,),
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
                                                  labelText: "Số tiền đã sửa xe:"
                                              ),
                                              onChanged: (value){
                                                totalCost = value;
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
                                                        "idDetailNAU": nau_list[index]["idDetailNAU"].toString(),
                                                        "idDeatil": detailVehicle_User["idDeatil"].toString(),
                                                        "km_accumulation": (kmthuong).toString(),
                                                        "totalCost": totalCost,
                                                      };
                                                      print(DateTime.now());
                                                      print(data);
                                                      String res = await BaseClient().createPost(data,'/History');
                                                      res == "success"
                                                          ? Fluttertoast.showToast(msg: "Post Add Successfully !")
                                                          : Fluttertoast.showToast(msg: "Error Add Post !");

                                                      Navigator.of(context).pop();
                                                      //setState(() {});
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
                      )),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
