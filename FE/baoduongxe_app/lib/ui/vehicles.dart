import 'package:baoduongxe_app/model/vehicle.dart';
import 'package:baoduongxe_app/ui/detail_vehicle.dart';
import 'package:flutter/material.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  // TextEditingController vehicleNameController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  // TextEditingController imageController = TextEditingController();
  // TextEditingController categoryVehicleIDController = TextEditingController();
  String? vehicleName = "";
  String? description = "";
  String? image = "";
  String? categoryVehicleID = '837ef4f8-9281-405e-f388-08dab45109be';


  // Widget buildNavgateButton() => FloatingActionButton(
  //     backgroundColor: Colors.grey.shade700,
  //       // showDialog(context: context,
  //       //     builder: (context)=>AlertDialog(
  //       //       title: const Text("Update ?",style: TextStyle(fontWeight: FontWeight.bold),),
  //       //       content: Container(
  //       //         height: 240,
  //       //         alignment: Alignment.topCenter,
  //       //         child: Column(
  //       //           mainAxisAlignment: MainAxisAlignment.start,
  //       //           children: [
  //       //             const Text('Vehicle Name:', style: TextStyle(fontWeight: FontWeight.bold),),
  //       //             TextField(
  //       //               controller: vehicleNameController,
  //       //             ),
  //       //             const SizedBox(height: 10,),
  //       //             const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold),),
  //       //             TextField(
  //       //               controller: descriptionController,
  //       //             ),
  //       //             const SizedBox(height: 10,),
  //       //             const Text('Image link:', style: TextStyle(fontWeight: FontWeight.bold),),
  //       //             TextField(
  //       //               controller: imageController,
  //       //             ),
  //       //           ],
  //       //         ),
  //       //       ),
  //       //
  //       //       actions: [
  //       //         TextButton(onPressed: (){
  //       //           Navigator.pop(context);
  //       //         }, child: const Text("NO",style: TextStyle(color: Colors.red),)),
  //       //         TextButton(onPressed: () {
  //       //           setState(() async {
  //       //             var _vehicle = Vehicle(
  //       //                 vehicleName: vehicleNameController.text.toString(),
  //       //                 description: descriptionController.text.toString(),
  //       //                 image: imageController.text.toString() ,
  //       //                 categoryVehicleName: txtcategoryVehicleID.toString());
  //       //             var response = await BaseClient()
  //       //                 .post('/Vehicles', _vehicle)
  //       //                 .catchError((err) {});
  //       //             if (response == null) return;
  //       //             debugPrint('Add success:');
  //       //             Navigator.pop(context);
  //       //           });
  //       //         }, child: const Text("YES"))
  //       //       ],
  //       //     ));
  //     child: const Icon(Icons.add));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff1e1e1e),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        title: const Text('Vehicles'),
        //leading: PopupMenuWidget(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade700,
          child: const Icon(Icons.add),
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
                                  labelText: "Vehicle Name"
                                ),
                                onChanged: (value){
                                  vehicleName = value;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    labelText: "Description"
                                ),
                                onChanged: (value){
                                  description = value;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    labelText: "Image"
                                ),
                                onChanged: (value){
                                  image = value;
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
                                          "vehicleName" : vehicleName,
                                          "description" : description,
                                          "image" : image,
                                          "categoryVehicleID": categoryVehicleID,
                                        };
                                        String res = await BaseClient().createPost(data, '/Vehicles');
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
                        )
                    )
            );
          }
      ),
      body: FutureBuilder(
        future: BaseClient().getPosts('/Vehicle'),
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
                  var test = Vehicle(
                    vehicleId: snapshot.data?[index]['vehicleId'],
                    vehicleName: snapshot.data?[index]['vehicleName'],
                    description: snapshot.data?[index]['description'],
                    image: snapshot.data?[index]['image'],
                    categoryVehicleID: snapshot.data?[index]['categoryVehicleName'],
                  );
                  return ListTile(
                    leading: CircleAvatar(
                           backgroundImage: NetworkImage(
                           snapshot.data?[index]['image']
                           ),
                    ),
                    title: Text(snapshot.data?[index]['vehicleName'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Text(snapshot.data?[index]['description'], style: const TextStyle(color: Colors.grey),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailVehicle(test)));
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
                                                      labelText: "Vehicle Name"
                                                  ),
                                                  onChanged: (value){
                                                    vehicleName = value;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      labelText: "Description"
                                                  ),
                                                  onChanged: (value){
                                                    description = value;
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      labelText: "Image"
                                                  ),
                                                  onChanged: (value){
                                                    image = value;
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
                                                            "vehicleName" : vehicleName,
                                                            "description" : description,
                                                            "image" : image,
                                                            "categoryVehicleID": categoryVehicleID,
                                                          };
                                                          String res = await BaseClient().editPost(data,'/Vehicles/${ snapshot.data?[index]['vehicleId'] }');
                                                          res == "success"
                                                              ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                                                              : Fluttertoast.showToast(msg: "Error Editing Post !");
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
                                          )
                                      )
                              );
                            },
                          )),
                          Expanded(child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.white,),
                            onPressed: () async {
                              Map<String, dynamic> data = {
                                "vehicleID": snapshot.data?[index]['vehicleId']
                              };
                              String res = await BaseClient().deletePost(data,'/Vehicles/${ snapshot.data?[index]['vehicleId'] }');
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
    // body: FutureBuilder(
    //   future: _vehicles,
    //   builder: (BuildContext context, AsyncSnapshot snapshot){
    //     var vehicle = snapshot.data;
    //     if (snapshot.hasData) {
    //       // return ListView.builder(
    //       //   itemCount: snapshot.data.length,
    //       //     itemBuilder: (BuildContext context, int index){
    //       //     return ListTile(
    //       //       leading: CircleAvatar(
    //       //         backgroundImage: NetworkImage(
    //       //           snapshot.data[index].image
    //       //         ),
    //       //       ),
    //       //       title: Text(snapshot.data[index].vehicleName, style: const TextStyle(color: Colors.white),),
    //       //       subtitle: Text(snapshot.data[index].description, style: const TextStyle(color: Colors.grey)),
    //       //       onTap: (){
    //       //         Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailVehicle(snapshot.data[index])));
    //       //       },
    //       //     );
    //       //     }
    //       // );
    //       return ListView.builder(
    //         itemCount: snapshot.data?.length ?? 0,
    //         itemBuilder: (context,index){
    //         return Card(
    //           color: const Color(0xE8020101),
    //           // height: 100,
    //           // padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: Padding(
    //             padding: const EdgeInsets.all(10.0),
    //             child: ListTile(
    //               leading: CircleAvatar(
    //                   backgroundImage: NetworkImage(
    //                     snapshot.data[index].image
    //                   ),
    //                 ),
    //               title: Text('${snapshot.data[index].vehicleName}',style: const TextStyle(color: Colors.white),),
    //               trailing: Container(
    //               width: 70,
    //               child: Row(
    //                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   //Expanded(flex: 1, child: Text('$stt',style: TextStyle(color: Colors.white))),
    //                   // Expanded(flex: 1, child: CircleAvatar(
    //                   //   backgroundImage: NetworkImage(snapshot.data[index].image),
    //                   //   child: IconButton(onPressed: () {
    //                   //     Navigator.push(context, new MaterialPageRoute(builder: (context) => DetailVehicle(snapshot.data[index])));
    //                   //   }, icon: const Icon(Icons.question_mark),),
    //                   // )),
    //                   //Expanded(flex: 3, child: Text('${vehicle.vehicleName}',style: const TextStyle(color: Colors.white),)),
    //                   // Expanded(flex: 3, child: Row(
    //                   //   mainAxisAlignment: MainAxisAlignment.end,
    //                   //   children: [
    //                   //     IconButton(
    //                   //       onPressed: () {
    //                   //         showDialog(context: context,
    //                   //             builder: (context)=>AlertDialog(
    //                   //               title: const Text("Update ?",style: TextStyle(fontWeight: FontWeight.bold),),
    //                   //               content: Container(
    //                   //                 height: 240,
    //                   //                 alignment: Alignment.topCenter,
    //                   //                 child: Column(
    //                   //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   //                   children: [
    //                   //                     const Text('Vehicle Name:', style: TextStyle(fontWeight: FontWeight.bold),),
    //                   //                     TextField(
    //                   //                       controller: vehicleNameController,
    //                   //                     ),
    //                   //                     const SizedBox(height: 10,),
    //                   //                     const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold),),
    //                   //                     TextField(
    //                   //                       controller: descriptionController,
    //                   //                     ),
    //                   //                     const SizedBox(height: 10,),
    //                   //                     const Text('Image link:', style: TextStyle(fontWeight: FontWeight.bold),),
    //                   //                     TextField(
    //                   //                       controller: imageController,
    //                   //                     ),
    //                   //                   ],
    //                   //                 ),
    //                   //               ),
    //                   //
    //                   //               actions: [
    //                   //                 TextButton(onPressed: (){
    //                   //                   Navigator.pop(context);
    //                   //                 }, child: const Text("NO",style: TextStyle(color: Colors.red),)),
    //                   //                 TextButton(onPressed: () async {
    //                   //                   var _vehicle = Vehicle(
    //                   //                       vehicleName: vehicleNameController.text.toString(),
    //                   //                       description: descriptionController.text.toString(),
    //                   //                       image: imageController.text.toString(),
    //                   //                       categoryVehicleName: txtcategoryVehicleID.toString());
    //                   //                   var response = await BaseClient()
    //                   //                       .put('/Vehicles/${snapshot.data[index].vehicleId}', _vehicle)
    //                   //                       .catchError((err) {});
    //                   //                   if (response == null) return;
    //                   //                   debugPrint('Edit success:');
    //                   //                 }, child: const Text("YES"))
    //                   //               ],
    //                   //             ));
    //                   //       },
    //                   //       icon: const Icon(Icons.edit, color: Colors.white),
    //                   //       hoverColor: Colors.lightBlueAccent.shade200,
    //                   //     ),
    //                   //
    //                   //     IconButton(
    //                   //       onPressed: () async {
    //                   //         showDialog(context: context,
    //                   //             builder: (context) {
    //                   //               return AlertDialog(
    //                   //                 title: const Text("Are you sure ?"),
    //                   //                 actions: [
    //                   //                   TextButton(onPressed: (){
    //                   //                     Navigator.pop(context);
    //                   //                   }, child: const Text("NO",style: TextStyle(color: Colors.red),)),
    //                   //                   TextButton(onPressed: () async {
    //                   //                     var response = await BaseClient()
    //                   //                         .delete('/Vehicles/${snapshot.data[index].vehicleId}')
    //                   //                         .catchError((err) {});
    //                   //                     if (response == null) return;
    //                   //                     debugPrint('Delete success:');
    //                   //                     Navigator.pop(context);
    //                   //                     //Navigator.push(context, MaterialPageRoute(builder: (context) => const MyVehicles()));
    //                   //                   }, child: const Text("YES"))
    //                   //                 ],
    //                   //               );
    //                   //             });
    //                   //       },
    //                   //       icon: const Icon(Icons.delete, color: Colors.white),
    //                   //       hoverColor: Colors.redAccent.shade200,
    //                   //     ),
    //                   //   ],
    //                   // ),
    //                   // ),
    //                   Expanded(
    //                     child: IconButton(onPressed: (){},
    //                         icon: const Icon(Icons.edit, color: Colors.white),
    //                         splashColor: Colors.blueAccent.withOpacity(0.5),
    //                     ),
    //                   ),
    //
    //                   Expanded(
    //                     child: IconButton(onPressed: (){
    //                       setState(() {
    //                         var response = BaseClient().delete('/Vehicles/${snapshot.data[index].vehicleId}').catchError((err){});
    //                         if (response == null) {
    //                           return;
    //                         }
    //                         debugPrint('Delete success');
    //                         snapshot.data;
    //                       });
    //                     },
    //                         icon: const Icon(Icons.delete, color: Colors.white),
    //                         splashColor: Colors.redAccent.withOpacity(0.5),
    //                     ),
    //                   ),
    //
    //                 ],
    //               ),
    //             ),
    //             ),
    //
    //             ),
    //           );
    //     });
    //
    //     }
    //     else if (snapshot.hasError) {
    //       return Container(
    //         child: const Center(child: Text('Not found data!')),
    //       );
    //     } else {
    //       return Container(
    //         child: const Center(child: CircularProgressIndicator()),
    //       );
    //     }
    //   },
    //
    // )
  }
}
