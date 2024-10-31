import 'dart:io';
import 'package:flutter/material.dart';
import 'post.dart';

class ProfileScreen extends StatelessWidget {
  final List<Post> posts;

  ProfileScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/default_profile_image.png'),
        ),
        SizedBox(height: 10),
        Text(
          '사용자명',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: posts.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 한 행에 3개의 이미지
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Image.file(
                      File(post.imagePath),
                      fit: BoxFit.cover,
                    );
                  },
                )
              : Center(
                  child: Text('게시물이 없습니다.'),
                ),
        ),
      ],
    );
  }
}
