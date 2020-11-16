import 'package:flutter/material.dart';
import 'package:serviceapp/metiers/post._detail.dart';

import 'package:serviceapp/metiers/post_model.dart';

import 'http_service.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post> posts = snapshot.data;
              print("aahahahahahahaha");
              print(posts[0]);
              print("aahahahahahahaha");

              return ListView(
                children: posts
                    .map(
                      (Post post) => ListTile(
                        title: Text(post.metier),
                        subtitle: Text(post.id.toString()),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post: post,
                          ),
                        )),
                      ),
                    )
                    .toList(),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
