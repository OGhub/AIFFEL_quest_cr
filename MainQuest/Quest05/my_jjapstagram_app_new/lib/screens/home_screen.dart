import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'create_post_screen.dart';
import 'profile_screen.dart';
import 'post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스
  List<Post> _posts = []; // 게시물 리스트

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addNewPost(Post post) {
    setState(() {
      _posts.insert(0, post); // 새로운 게시물을 리스트의 앞에 추가
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      FeedScreen(posts: _posts),
      CreatePostScreen(onPostCreated: _addNewPost),
      ProfileScreen(posts: _posts),
    ];

    return Scaffold(
      body: _pages[_selectedIndex], // 현재 선택된 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        onTap: _onItemTapped, // 탭 아이템 클릭 시 호출되는 함수 지정
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '피드'),
          BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), label: '게시물 작성'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
    );
  }
}
