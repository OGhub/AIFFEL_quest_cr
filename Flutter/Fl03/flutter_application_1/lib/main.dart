import 'package:flutter/material.dart'; // 플러터의 기본 위젯들을 가져옵니다.

void main() {
  runApp(MyApp()); // 앱 실행 시작 지점입니다.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(), // 앱이 시작할 때 표시할 첫 번째 페이지를 설정합니다.
    );
  }
}

// 첫 번째 페이지를 위한 StatefulWidget
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

// 첫 번째 페이지의 상태를 관리하는 클래스
class _FirstPageState extends State<FirstPage> {
  bool isCat = true; // 고양이인지 강아지인지 구분하는 변수를 true로 초기화

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'), // 첫 번째 페이지의 제목
        leading: Icon(Icons.pets), // 앱바의 왼쪽에 고양이 아이콘 추가
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙에 정렬
          children: [
            GestureDetector(
              onTap: () {
                // 이미지 클릭 시 현재 is_cat 상태를 출력
                print("is_cat: $isCat");
              },
              child: Image.asset(
                'assets/cat.png', // assets 폴더에 있는 고양이 이미지 로드
                width: 300,
                height: 300,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCat = false; // 버튼을 누르면 is_cat 값을 false로 변경
                });
                // 다음 페이지로 이동하면서 is_cat 값을 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(isCat: isCat),
                  ),
                );
              },
              child: Text('Next'), // 버튼 텍스트
            ),
          ],
        ),
      ),
    );
  }
}

// 두 번째 페이지로 데이터(isCat)를 전달받는 StatelessWidget
class SecondPage extends StatelessWidget {
  final bool isCat; // FirstPage에서 전달받는 변수

  // 생성자를 통해 isCat 값을 받음
  SecondPage({required this.isCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'), // 두 번째 페이지의 제목
        leading: Icon(Icons.pets), // 앱바의 왼쪽에 강아지 아이콘 추가
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙에 정렬
          children: [
            GestureDetector(
              onTap: () {
                // 이미지 클릭 시 현재 is_cat 상태를 출력
                print("is_cat: $isCat");
              },
              child: Image.asset(
                'assets/dog.png', // assets 폴더에 있는 강아지 이미지 로드
                width: 300,
                height: 300,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 버튼을 누르면 이전 페이지로 돌아감
                Navigator.pop(context);
              },
              child: Text('Back'), // 버튼 텍스트
            ),
          ],
        ),
      ),
    );
  }
}
