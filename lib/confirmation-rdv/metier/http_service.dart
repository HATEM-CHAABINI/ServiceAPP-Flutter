import 'dart:convert';
import 'package:http/http.dart';
import 'package:serviceapp/confirmation-rdv/metier/post_model.dart';


class HttpService {
  final String postUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<void> deletePost(int id) async {
    Response res = await delete("$postUrl/$id");

    if (res.statusCode == 200) {
      print("Deleted!");
    }
  }

  Future<List<service>> getPosts() async {
    Response res = await get("http://10.0.2.2:3000/affServiceDemanderNonConfirmer/hatem@gmail.com");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<service> posts =
          body.map((dynamic item) => service.fromJson(item)).toList();
      return posts;
    } else {
      throw "can't get posts.";
    }
  }
}


