import 'dart:convert' as convert;
import 'package:baoduongxe_app/model/accessary.dart';
import 'package:baoduongxe_app/ui/detail_NAU.dart';
import 'package:baoduongxe_app/ui/home.dart';
import 'package:baoduongxe_app/ui/login.dart';
import 'package:flutter/material.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



class MyDetailNau extends StatefulWidget {
  const MyDetailNau({Key? key}) : super(key: key);

  @override
  State<MyDetailNau> createState() => _MyDetailNauState();
}

class _MyDetailNauState extends State<MyDetailNau> {

  var vehicles = [];
  var accessaries = [];
  var detailNAU = [];
  var units = [];
  var categoryVehicles = [];
  var temp = [];
  var tam = [];
  var x;


  String? categoryVehicle;
  String? vehicle;
  String? vehicleID = "";


  bool isCategorySelected = false;
  bool isVehicleSelected = false;

  int? kmcurrent = 0;

  Future getData(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        categoryVehicles = jsonResponse;
      });
    }
  }

  Future getData2(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        vehicles = jsonResponse;
      });
    }
  }

  Future getData3(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        accessaries = jsonResponse;
      });
    }
  }

  Future getData4(String api) async {
    await Future.delayed(const Duration(milliseconds: 100));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        detailNAU = jsonResponse;
      });
    }
  }

  Future getData5(String api) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      setState(() {
        units = jsonResponse;
      });
    }
  }

  @override
  void initState() {
    // categoryVehicles = [];
    // vehicles = [];
    // accessaries = [];
    // detailNAU = [];
    // units = [];
    getData('/CategotyVehicle');
    getData2('/Vehicles');
    getData3('/Accessary');
    getData4('/DetailNAU');
    getData5('/Units');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Vehicles',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff252525),
      ),

        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.shade700,
            child: const Icon(Icons.add),
            onPressed: () async {
              if (isVehicleSelected == false) {
                showDialog(context: context, builder: (context) =>
                  SimpleDialog(
                    alignment: Alignment.center,
                    title: const Text("Bạn chưa chọn xe muốn thêm!"),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){Navigator.of(context).pop();},
                            child: const Text("OK", style: TextStyle(color: Colors.cyan),),)
                        ],
                      )
                    ],
                  )
                );
              } else{
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          backgroundColor: Colors.white,
                            alignment: Alignment.center,
                            title: Text("Bạn có muốn thêm xe '${x["vehicleName"]}' không?",style: TextStyle(color: Colors.black),),
                            content: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            labelText: "Số km hiện tại của xe: "
                                        ),
                                        onChanged: (value){
                                          kmcurrent = int.tryParse(value);
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
                                          var data = {
                                            "vehicleID": x["vehicleID"],
                                            "userID": getUser["userID"],
                                            //"userID": 1,
                                            "kM_Current": kmcurrent
                                          };

                                          String res = await BaseClient().createPost(data, '/DetailVehicle_User');
                                          res == "success"
                                              ? Fluttertoast.showToast(msg: "Post Created Successfully !")
                                              : Fluttertoast.showToast(msg: "Error Creating Post !");
                                          Navigator.of(context).pop();
                                          setState(() {

                                          });
                                              },
                                              child: const Text("Add")
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
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     TextButton(
                                  //         onPressed: () async {
                                  //           var data = {
                                  //             "vehicleID": x["vehicleID"],
                                  //             "userID": getUser["userID"],
                                  //             //"userID": 1,
                                  //             "kM_Current": 0
                                  //           };
                                  //
                                  //           String res = await BaseClient().createPost(data, '/DetailVehicle_User');
                                  //           res == "success"
                                  //               ? Fluttertoast.showToast(msg: "Post Created Successfully !")
                                  //               : Fluttertoast.showToast(msg: "Error Creating Post !");
                                  //           Navigator.of(context).pop();
                                  //           setState(() {
                                  //
                                  //           });
                                  //         },
                                  //         child: const Text("Add")
                                  //     ),
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         Navigator.of(context).pop();
                                  //         setState(() {});
                                  //       },
                                  //       child: const Text("Cancel", style: TextStyle(color: Colors.red),),
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                        )
                );
              }
            }
        ),

      body: Container(
        padding:  const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (categoryVehicles.isEmpty) const Center(child: CircularProgressIndicator())
            else Card(
              color: const Color(0xff252525),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff252525),
                  underline: Container(),
                  hint: const Text("Select Category",style: TextStyle(color: Colors.white),),
                  icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  isDense: true,
                  isExpanded: true,
                  items: categoryVehicles.map((cate){
                    return DropdownMenuItem<String>(
                      value: cate["categoryVehicleName"],
                      child: Text(cate["categoryVehicleName"],style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  value: categoryVehicle,
                  onChanged: (value){
                    setState(() {
                      if (vehicle != null) {
                        vehicle = null;
                      }

                      temp = [];
                      categoryVehicle = value!;
                      for (int i = 0; i< categoryVehicles.length; i++){
                        if (categoryVehicles[i]["categoryVehicleName"] == value) {
                          temp = vehicles.where((e) => e["categoryVehicleID"] == categoryVehicles[i]["categoryVehicleID"]).toList();
                        }
                      }

                      isCategorySelected = true;
                    });
                  },
                ),
              ),
            ),

            if (isCategorySelected) Card(
              color: const Color(0xff252525),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: const EdgeInsets.all(7),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff252525),
                  underline: Container(),
                  hint: const Text("Select Vehicle",style: TextStyle(color: Colors.white),),
                  icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  isDense: true,
                  isExpanded: true,
                  items: temp.map((st){
                    return DropdownMenuItem<String>(
                      value: st["vehicleName"],
                      child: Text(st["vehicleName"],style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  value: vehicle,
                  onChanged: (value){
                    setState(() {
                      tam = [];
                      vehicle = value!;
                      for (int i = 0; i< temp.length; i++){
                        if (temp[i]["vehicleName"] == value) {
                          x = temp.firstWhere((e) => e["vehicleID"] == temp[i]["vehicleID"]);
                        }
                      }
                      tam = detailNAU.where((e) => e["vehicleID"] == x["vehicleID"]).toList();
                      isVehicleSelected = true;
                    });
                  },
                ),
              ),
            ) else  Card(
              color: const Color(0xff252525),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: const EdgeInsets.all(7),
                child: DropdownButton<String>(
                  underline: Container(),
                  hint: const Text("Select Vehicle",style: TextStyle(color: Colors.white),),
                  icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                  isDense: true,
                  isExpanded: true,
                  items: null,
                  value: null,
                  onChanged: null,
                ),
              ),
            ),
            const SizedBox(height: 10,),

            Container(
              height: 20,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: const Text("Danh sách đề xuất bảo dưỡng xe: ",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            const SizedBox( height: 6,),

            if(tam.isEmpty) const Center(child: Text("Empty !",style: TextStyle(color: Colors.grey),))
              // const Center(child: CircularProgressIndicator())
            //else if(tam.length == 0) const Center(child: Text("Has error !"))
            else Expanded(
              child: ListView.builder(
                  itemCount: tam.length,
                  itemBuilder: (context,index){
                    var z = units.firstWhere((e) => e["unitID"] == tam[index]["unitID"]);
                    var a = accessaries.firstWhere((e) => e["accessaryID"] == tam[index]["accessaryID"]);
                    var b = Accessary(
                      accessaryId: a["accessaryID"],
                      accessaryName: a["accessaryName"],
                      image: a["image"],
                    );
                    return ListTile(
                        leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            //tam[index]['image'],
                          b.image.toString(),
                    ),
                    ),
                    title: Text(b.accessaryName.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      subtitle: Text(b.accessaryId.toString() , style: const TextStyle(color: Colors.grey),),
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailNAU(b,tam[index],z)));
                    },);
                  }),
            )

          ],
        ),
      )
    );
  }
}
