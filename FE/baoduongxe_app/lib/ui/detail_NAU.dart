import 'package:baoduongxe_app/model/accessary.dart';
import 'package:baoduongxe_app/ui/constants.dart';
import 'package:flutter/material.dart';
import '../services/base_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetailNAU extends StatelessWidget{

  var accessaryID;
  Accessary accessary;
  var detailNAU;
  var unit;


  DetailNAU(this.accessary, this.detailNAU, this.unit);

  Future getData(String api) async {
    var response = await http.get(Uri.parse(baseUrl + api));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    }
  }


  //Size size = Size(520, 740);

  @override
  Widget build(BuildContext context){
    //print(detailNAU);
    //var a = detailNAU.singleWhere((e) => e["accessaryID"] == accessary.accessaryId);
    return Scaffold(
      appBar: AppBar(title: Text(accessary.accessaryName.toString()), backgroundColor: const Color(0xff252525), elevation: 0,),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
              child: Container(
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                alignment: Alignment.topCenter,
                height: 360,
                child: Image.network(accessary.image.toString(), fit: BoxFit.cover,),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${accessary.accessaryName}\n",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Số Kilomet:  ${detailNAU["km_Min"]} Km - ${detailNAU["km_Max"]} Km\n"
                            "Số lần:  ${detailNAU["countPerforation"]}\n"
                            "Đơn vị tính:  ${unit["unitName"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                // Text(
                //   "Số lần: ${detailNAU["countPerforation"]}\nĐơn vị tính: ${unit["unitName"]}",
                //   style: Theme.of(context)
                //       .textTheme
                //       .headline6!
                //       .copyWith(color: kPrimaryColor),
                // )
              ],
            ),
          ),
            //const SizedBox(height: kDefaultPadding),
            const SizedBox(height: 40,),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("More information >>",style: TextStyle(color: Colors.cyan),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}