import 'package:flutter/material.dart';
import '../model/vehicle.dart';

class DetailVehicle extends StatelessWidget{
  final Vehicle vehicle;
  DetailVehicle(this.vehicle);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(vehicle.vehicleName.toString()), backgroundColor: const Color(0xff252525), elevation: 0,),
      backgroundColor: Colors.black,
      body: Container(
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
          height: 240,
          child: Image.network(vehicle.image.toString()),
        ),

      ),
    );
  }
}