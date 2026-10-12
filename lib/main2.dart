import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. MaterialApp: 앱의 시작점
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Widget Tree Example',
      home: MyScreen(), // 2. Scaffold를 가진 화면으로 연결
    );
  }
}

// 2. Scaffold: 한 화면의 틀 (상단바, 배경, 본문 영역 등 제공)
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위젯 트리 예제'),
        backgroundColor: Colors.teal,
      ),
      // body 내부에서 위젯 트리가 아래로 이어집니다.
      body: ListView( // 3. ListView: 스크롤이 가능한 본문 영역
        padding: const EdgeInsets.all(16.0),
        children: const [
          
          Card( // 4. Card: 관련 정보를 시각적으로 묶어주는 상자
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text( // 5. Text: 실제 화면에 출력되는 글자
                '안녕하세요! Card 내부의 Text입니다.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Card( // 반복해서 여러 개를 넣을 수도 있습니다.
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'ListView 덕분에 항목이 많아져도 스크롤이 가능해요.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
