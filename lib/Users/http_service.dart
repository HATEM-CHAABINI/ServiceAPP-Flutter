import 'dart:convert';
import 'package:http/http.dart';
import 'package:serviceapp/Users/post_model.dart';


class HttpService {
  final String postUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<void> deletePost(int id) async {
    Response res = await delete("$postUrl/$id");

    if (res.statusCode == 200) {
      print("Deleted!");
    }
  }

  Future<List<User>> getPosts() async {
    Response res = await get("http://10.0.2.2:3000/personnoc/hatem@gmail.com");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<User> posts =
          body.map((dynamic item) => User.fromJson(item)).toList();
      return posts;
    } else {
      throw "can't get posts.";
    }
  }
}


