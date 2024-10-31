import 'dart:io';
import 'package:flutter/material.dart';
import 'post.dart';

class FeedScreen extends StatelessWidget {
  final List<Post> posts;

  FeedScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return posts.isNotEmpty
        ? ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                child: Column(
                  children: [
                    Image.file(
                      File(post.imagePath),
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                      title: Text(post.description),
                    ),
                  ],
                ),
              );
            },
          )
        : Center(
            child: Text('게시물이 없습니다.'),
          );
  }
}
