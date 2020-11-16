import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'metier.dart';
/*
class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<Metier> cars = [
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    http.get("http://10.0.2.2:3000/metier")
        .then((http.Response response){
      List<dynamic>carsFromServer = json.decode(response.body);
      for(int i=0; i<carsFromServer.length;i++){
        Map<String,dynamic> carJ  = carsFromServer[i]; //Chaque bloc JSON est une Voiture de type Map
        print(carJ['id']);
        print(carJ['metier']);
        cars.add(Metier(carJ['id'],carJ['metier'])); //Alimenter mon dataSource (cars)
      }
      print(">>>>>>> "+cars.length.toString());
    });

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("voiture"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CarView(
              cars[index].id, cars[index].metier);
        },
        itemCount: cars.length,
      ),
      // body: ListView(
      //   children: [
      //     CarView("peugeot","208","Images/208.jpg"),
      //     CarView("peugeot","206","Images/bmw.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //   ],
      // ),
    );
  }
}

class car {
  String carId;
  String carMake;
  String carModel;
  String imageUrl;
  String description;
  int quantity;

  car(this.carMake, this.carModel, {this.imageUrl, this.quantity,this.description});

  @override
  String toString() {
    return 'car{carId: $carId, carMake: $carMake, carModel: $carModel, imageUrl: $imageUrl, description: $description, quantity: $quantity}';
  }
}
*/