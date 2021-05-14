import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/custom_image.dart';
import 'package:flutter_share/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
