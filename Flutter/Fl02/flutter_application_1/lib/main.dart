import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('플러터 앱 만들기'),
        leading: Icon(Icons.menu), // 좌측 상단 아이콘
        backgroundColor: Colors.blue, // AppBar 색상 지정
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: ()  {
                print('버튼이 눌렸습니다'); // 버튼 클릭 시 Debug Console에 출력
              },
              child: Text('Text'),
            ),
            SizedBox(height: 100), // 버튼과 컨테이너 간 간격 조정
            Container(
              width: 300,
              height: 300,
              child: Stack(
              children: [
                for (int i = 0; i < 5; i++)
                Positioned(
                  child: Container(
                  width: 300 - i * 60.0,
                  height: 300 - i * 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  ),
                ),
              ],
              ),
            ),
            ],
          ),
          ),
        );
        }
      }
