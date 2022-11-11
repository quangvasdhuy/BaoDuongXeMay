import 'package:flutter/material.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;

class MyAccessaries extends StatefulWidget {
  const MyAccessaries({Key? key}) : super(key: key);

  @override
  State<MyAccessaries> createState() => _MyAccessariesState();
}

class _MyAccessariesState extends State<MyAccessaries> {
  Icon cusIcon = const Icon(Icons.search);
  Widget cusSearchBar = const Text('Accessaries');
  String? accessaryName = "";
  String? image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff1e1e1e),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        actions: <Widget>[
          IconButton(onPressed: (){
            setState(() {
              if (this.cusIcon.icon == Icons.search) {
                this.cusIcon = const Icon(Icons.cancel);
                this.cusSearchBar = const TextField(
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey,),
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                );
              }  else {
                this.cusIcon = const Icon(Icons.search);
                this.cusSearchBar = const Text('Accessaries');
              }
            });
          },
              icon: cusIcon)
        ],
        //leading: PopupMenuWidget(),
        title: cusSearchBar,
      ),
      body: FutureBuilder(
        future: BaseClient().getPosts('/Accessary'),
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
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data?[index]['image']
                      ),
                    ),
                    title: Text(snapshot.data?[index]['accessaryName'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailVehicle(test)));
                    },
                    // trailing: Container(
                    //   width: 70,
                    //   child: Row(
                    //     children: [
                    //       Expanded(child: IconButton(
                    //         icon: Icon(Icons.edit, color: Colors.white,),
                    //         onPressed: () {
                    //           showDialog(
                    //               barrierDismissible: false,
                    //               context: context,
                    //               builder: (context) =>
                    //                   AlertDialog(
                    //                       content: Form(
                    //                         child: Column(
                    //                           mainAxisSize: MainAxisSize.min,
                    //                           children: [
                    //                             TextFormField(
                    //                               decoration: InputDecoration(
                    //                                   filled: true,
                    //                                   fillColor: Colors.grey[200],
                    //                                   labelText: "Vehicle Name"
                    //                               ),
                    //                               onChanged: (value){
                    //                                 vehicleName = value;
                    //                               },
                    //                             ),
                    //                             const SizedBox(
                    //                               height: 12,
                    //                             ),
                    //                             TextFormField(
                    //                               decoration: InputDecoration(
                    //                                   filled: true,
                    //                                   fillColor: Colors.grey[200],
                    //                                   labelText: "Description"
                    //                               ),
                    //                               onChanged: (value){
                    //                                 description = value;
                    //                               },
                    //                             ),
                    //                             const SizedBox(
                    //                               height: 12,
                    //                             ),
                    //                             TextFormField(
                    //                               decoration: InputDecoration(
                    //                                   filled: true,
                    //                                   fillColor: Colors.grey[200],
                    //                                   labelText: "Image"
                    //                               ),
                    //                               onChanged: (value){
                    //                                 image = value;
                    //                               },
                    //                             ),
                    //                             const SizedBox(
                    //                               height: 12,
                    //                             ),
                    //                             Row(
                    //                               mainAxisAlignment: MainAxisAlignment.end,
                    //                               children: [
                    //                                 TextButton(
                    //                                     onPressed: () async {
                    //                                       Map<String, dynamic> data = {
                    //                                         "vehicleName" : vehicleName,
                    //                                         "description" : description,
                    //                                         "image" : image,
                    //                                         "categoryVehicleID": categoryVehicleID,
                    //                                       };
                    //                                       String res = await BaseClient().editPost(data,'/Vehicles/${ snapshot.data?[index]['vehicleId'] }');
                    //                                       res == "success"
                    //                                           ? Fluttertoast.showToast(msg: "Post Edited Successfully !")
                    //                                           : Fluttertoast.showToast(msg: "Error Editing Post !");
                    //                                       Navigator.of(context).pop();
                    //                                       setState(() {
                    //
                    //                                       });
                    //                                     },
                    //                                     child: const Text("Add")
                    //                                 ),
                    //                                 TextButton(
                    //                                   onPressed: () {
                    //                                     Navigator.of(context).pop();
                    //                                     setState(() {});
                    //                                   },
                    //                                   child: const Text("Cancel", style: TextStyle(color: Colors.red),),
                    //                                 )
                    //                               ],
                    //                             )
                    //                           ],
                    //                         ),
                    //                       )
                    //                   )
                    //           );
                    //         },
                    //       )),
                    //       Expanded(child: IconButton(
                    //         icon: Icon(Icons.delete, color: Colors.white,),
                    //         onPressed: () async {
                    //           Map<String, dynamic> data = {
                    //             "vehicleID": snapshot.data?[index]['vehicleId']
                    //           };
                    //           String res = await BaseClient().deletePost(data,'/Vehicles/${ snapshot.data?[index]['vehicleId'] }');
                    //           res == "success"
                    //               ? Fluttertoast.showToast(msg: "Post Deleted Successfully !")
                    //               : Fluttertoast.showToast(msg: "Error Deleting Post !");
                    //           setState(() {
                    //
                    //           });
                    //         },
                    //       ))
                    //     ],
                    //   ),
                    // ),
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
