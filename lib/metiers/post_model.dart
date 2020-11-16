import 'package:flutter/foundation.dart';

class Post {
  final int id;
  final String metier;

  Post(
      {
      @required this.id,
      @required this.metier,
      });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as int,
        metier: json['metier'] as String);
  }
}
