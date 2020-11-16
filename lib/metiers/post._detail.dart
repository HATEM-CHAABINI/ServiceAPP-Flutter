import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:serviceapp/Inscription-connexion/metier.dart';
import 'package:serviceapp/metiers/post_model.dart';

import 'http_service.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final HttpService httpService = HttpService();

  PostDetail({@required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.metier),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await httpService.deletePost(post.id);
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("ID"),
                  subtitle: Text("${post.id}"),
                ),
                ListTile(
                  title: Text("Body"),
                  subtitle: Text(post.metier),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
