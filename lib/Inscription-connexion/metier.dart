/*class Metier {
  final String id;
  final String metier;

  Metier({this.id, this.metier});

  factory Metier.fromJson(Map<String, dynamic> json) {
    return Metier(
      id: json["id"].toString(),
      metier: json["metier"] as String,
    );
  }
}*/
import 'package:flutter/foundation.dart';

class Metier {
  final int id;
  final String metier;
  Metier(this.id, this.metier);

  @override
  String toString() {
    return 'Metier{MetierId: $id, Metier: $metier}';
  }
}
