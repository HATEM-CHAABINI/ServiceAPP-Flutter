import 'package:flutter/foundation.dart';

class service {
  final int id;
  final String email;
  final String name;
  final String username;
  final String numtel;
  final String adresse;
  final String ville;
  final String metier;
  final String codepostale;
  final double prix;
  final String image;
  final int idS;
  final String dateD;
  final String statut;
  final String commentaire;




  service(
      {
      @required this.id,
      @required this.email,
      @required this.name,
      @required this.username,
      @required this.numtel,
      @required this.adresse,
        @required this.ville,
        @required this.metier,

      @required this.codepostale,
      @required this.prix,
        @required this.image,
        @required this.idS,
        @required this.dateD,
        @required this.statut,
        @required this.commentaire,
});


  factory service.fromJson(Map<String, dynamic> json) {
    return service(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      numtel: json['numtel'] as String,
      adresse: json['adresse'] as String,
      ville: json['ville'] as String,
      metier: json['metier'] as String,
      codepostale: json['codepostale'] as String,
      prix: json['prix'] as double,
      idS: json['idS'] as int,
      dateD: json['dateD'] as String,
      statut: json['statut'] as String,
      commentaire: json['commentaire'] as String,
    );
  }
}
