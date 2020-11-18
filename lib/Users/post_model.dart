import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String firebaseid;
  final String token;
  final String email;
  final String name;
  final String username;
  final String encrypted_password;
  final String salt;
  final String numtel;
  final String adresse;
  final String metier;
  final String ville;
  final String codepostale;
  final double prix;
  final String image;


  User(
      {
      @required this.id,
      @required this.firebaseid,
      @required this.token,
      @required this.email,
      @required this.name,
      @required this.username,
      @required this.encrypted_password,
      @required this.salt,
      @required this.numtel,
      @required this.adresse,
      @required this.metier,
      @required this.ville,
      @required this.codepostale,
      @required this.prix,
      @required this.image,
});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firebaseid: json['firebaseid'] as String,
      token: json['token'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      encrypted_password: json['encrypted_password'] as String,
      salt: json['salt'] as String,
      numtel: json['numtel'] as String,
      adresse: json['adresse'] as String,
      metier: json['metier'] as String,
      ville: json['ville'] as String,
      codepostale: json['codepostale'] as String,
      prix: json['prix'] as double,
      image: json['image'] as String,
    );
  }
}
