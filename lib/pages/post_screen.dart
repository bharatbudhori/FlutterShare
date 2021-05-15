import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/post.dart';
import 'home.dart';

class PostScreen extends StatelessWidget {
  final String postId;
  final String userId;

  PostScreen({
    this.postId,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postRef.doc(userId).collection('userPosts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text(
                post.description,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: ListView(
              children: [
                Container(
                  child: post,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
