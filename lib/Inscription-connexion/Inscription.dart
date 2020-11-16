import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:multipart_request/multipart_request.dart';
import 'package:serviceapp/metiers/http_service.dart';
import 'package:serviceapp/utilities/constants.dart';

import 'metier.dart';

class Inscription extends StatefulWidget {

  @override
  _InscriptionState createState() => _InscriptionState();


}

class _InscriptionState extends State<Inscription> {
  //File file;
  int selectedValue =0;
  int selectedValueMetier =0;
  final HttpService httpService = HttpService();
  List<Metier> metiers = [];
  Metier leMetier ;
  String laVille;
  TextEditingController mail = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController numtel = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController codePostale = TextEditingController();
  File file;
  String base64Image;
  File _image;

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
        metiers.add(Metier(carJ['id'],carJ['metier'])); //Alimenter mon dataSource (cars)
      }
      print(">>>>>>> "+metiers.length.toString());
    });

    setState((){});
  }
  Future register( ) async {
    var request = MultipartRequest();

    request.setUrl("http://10.0.2.2:3000/newupload");
    request.addFile("upload", _image.path);
    request.addField("password", pass.text);
    request.addField("name", name.text);
    request.addField("email", mail.text);
    request.addField("username", username.text);
    request.addField("numtel", numtel.text);
    request.addField("adresse", adresse.text);
    request.addField("metier", leMetier.metier);
    request.addField("ville", laVille);
    request.addField("codepostale", codePostale.text);
    request.addField("prix", '0');
    request.addField("firebaseid", "null");
    request.addField("token", "null");

    Response response = request.send();

    response.onError = () {
      print("Error");
    };

    response.onComplete = (response) {
      print(response);
    };

    response.progress.listen((int progress) {
      print("progress from response object " + progress.toString());
    });


  }





  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }



  Widget _buildname() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Nom et Prenom',
              hintStyle: kHintTextStyle,
            ), controller: name,
          ),
        ),
      ],
    );
  }
  Widget _buildusername() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Nom d utilisateur',
              hintStyle: kHintTextStyle,
            ), controller: username,
          ),
        ),
      ],
    );
  }Widget _buildadresse() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Adresse',
              hintStyle: kHintTextStyle,
            ), controller: adresse,
          ),
        ),
      ],
    );
  }
  Widget _buildEmail() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "email",
              hintStyle: kHintTextStyle,
            ), controller: mail,
          ),
        ),
      ],
    );
  }
  Widget _buildnumtel() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Numero de telephone",
              hintStyle: kHintTextStyle,
            ), controller: numtel,
          ),
        ),
      ],
    );
  }
  Widget _buildpassword() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ), controller: pass,
          ),
        ),
      ],
    );
  }
  static const List<String> VilleList = [
    "Ariana",
    "Béja",
    "Ben Arous",
    "Bizerte",
    "Gabès",
    "Gafsa",
    "Jendouba",
    "Kairouan",
    "Kasserine",
    "Kébili",
    "Le Kef",
    "Mahdia",
    "La Manouba",
    "Médenine",
    "Monastir",
    "Nabeul",
    "Sfax",
    "Sidi Bouzid",
    "Siliana",
    "Sousse",
    "Tataouine",
    "Tozeur",
    "Tunis",
    "Zaghouan",
  ];

  Widget _buildmetierpicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(

            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: CupertinoPicker(

              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (value) {
             //   print(metiers[value]);
                setState(() {
                  selectedValueMetier = value;
                  leMetier = metiers[value];
                  print(leMetier);
                });
              },
              itemExtent: 32.0,

              children: <Widget> [
             //   Text('Item01',style: TextStyle(color: selectedValue == 0 ? Colors.white : Colors.black),),
              //  Text('Item02',style: TextStyle(color: selectedValue == 1 ? Colors.white : Colors.black),),
              //  Text('Item03',style: TextStyle(color: selectedValue == 2 ? Colors.white : Colors.black),),

    for (Metier ville in metiers)

      Text( ville.metier ,style: TextStyle(color: selectedValueMetier == metiers.indexOf(ville) ? Colors.white : Colors.black),),

              ],
            )


        ),
      ],
    );
  }


  Widget _buildcodePostal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: "Code Postale",
              hintStyle: kHintTextStyle,
            ), controller: codePostale,
          ),
        ),
      ],
    );
  }

  Widget _buildvillepicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 10.0),
        Container(


            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: CupertinoPicker(

              backgroundColor: Colors.transparent,
              onSelectedItemChanged: (value) {
              //  print(VilleList[value]);
                setState(() {
                  selectedValue = value;
                  laVille = VilleList[value];
                });
              },
              itemExtent: 32.0,

              children: <Widget> [
                //   Text('Item01',style: TextStyle(color: selectedValue == 0 ? Colors.white : Colors.black),),
                //  Text('Item02',style: TextStyle(color: selectedValue == 1 ? Colors.white : Colors.black),),
                //  Text('Item03',style: TextStyle(color: selectedValue == 2 ? Colors.white : Colors.black),),
                for (String ville in VilleList)
                  Text( ville ,style: TextStyle(color: selectedValue == VilleList.indexOf(ville) ? Colors.white : Colors.black),),

              ],
            )


        ),
      ],
    );
  }


  Widget _verifpassword() {
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
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'confirm password',
              hintStyle: kHintTextStyle,
            ), controller: repass,
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
        //elevation: 5.0,
        onPressed: ()=>print(
            register()
//            leMetier.metier + " " + laVille + " " +mail.text+ " " +username.text+ " " +pass.text+ " " +repass.text+ " " +name.text+ " " +numtel.text+ " " +adresse.text+ " " +codePostale.text

        ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color.fromRGBO(118, 0, 4, 1),
        child: Text(
          'register',
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
                        image: AssetImage('assets/images/bac.png'),fit:BoxFit.cover
                    )
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Inscription' ,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Color.fromRGBO(118, 0, 4, 1),
                            child: _image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                      //_uploadpic(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildname(),
                      _buildusername(),
                      _buildEmail(),
                      _buildnumtel(),
                      _buildpassword(),
                      _verifpassword(),
                      _buildadresse(),
                      _buildvillepicker(),
                      _buildmetierpicker(),
                      _buildcodePostal(),
                      _buildLoginBtn(),

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