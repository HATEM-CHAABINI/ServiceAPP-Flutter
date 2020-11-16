import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:http/http.dart' as http;

import 'Inscription.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}


class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  //BuildContext context;

  void goInscription(){

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context){
          return Inscription();
        }
        ), (Route<dynamic> route) => false);


  }


  Future login() async {


    Map<String,String> headers = {
      "Content-Type" : "application/json; charset=UTF-8"
    };

    Map<String,dynamic> carData = {
      'email': user.text,
      'password': pass.text,
    };

    http.post("http://10.0.2.2:3000/login/",headers:headers,body:json.encode(carData))
        .then((http.Response response) async {
      print(response.body);
      //nchouf Wrong Password wala le
      Map<String,dynamic> carJ  = json.decode(response.body); //Chaque bloc JSON est une Voiture de type Map
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('firebaseid', carJ['firebaseid']);
      await prefs.setString('token', carJ['token']);
      await prefs.setString('email', carJ['email']);
      await prefs.setString('name', carJ['name']);
      await prefs.setString('username', carJ['username']);
      await prefs.setString('numtel', carJ['numtel']);
      await prefs.setString('adresse', carJ['adresse']);
      await prefs.setString('metier', carJ['metier']);
      await prefs.setString('ville', carJ['ville']);
      await prefs.setString('codepostale', carJ['codepostale']);
      await prefs.setDouble('prix', carJ['prix']);
      await prefs.setString('image', carJ['image']);
print("aajahdcbhfbhbcfhbchfbvhfbv");
      print(await prefs.get("adresse"));
      print("aajahdcbhfbhbcfhbchfbvhfbv");

      String message =response.statusCode == 201 ? "Car added!" : "Something wrong";
      print(message);
      showDialog(
         context:context,
         builder: (context) {
           return AlertDialog(
             title: Text("my car"),
             content: Text(message),

           );
         },
       );
     // Navigator.pushNamed(context, "/");
    });


/*
    var url = "http://10.0.2.2:3000/login/";
    var response = await http.post(url,body: jsonEncode(<String, String>{

      'email': user.text,
      'password': pass.text,
    }),);

    var data = json.decode(response.body);
    print(data["id"]);
    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'Username and password valid');
    } else {
      Fluttertoast.showToast(msg: 'Username and password invalid');

    }*/
  }


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Votre Email',
              hintStyle: TextStyle( color: Colors.black),
            ),
            controller: user,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Mot de Passe',
              hintStyle: TextStyle( color: Colors.black),

             // hintStyle: kHintTextStyle,
            ),controller: pass,
          ),
        ),
      ],
    );
  }



  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          login();

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color.fromRGBO(118, 0, 4, 1),
        child: Text(
          'Connexion',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }




  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        goInscription();

      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Vous n\'avez pas de Compte? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Inscrivez vous',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/headerbg.jpg'),fit:BoxFit.cover
                    )
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: 150.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),

                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

