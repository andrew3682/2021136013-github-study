import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(), // 첫 번째 화면으로 시작
    );
  }
}

// ==========================================
// 1. 첫 번째 화면 (새 화면 열기)
// ==========================================
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('첫 번째 화면')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // [Button 활용 예시] 사용자의 누르기 받기
            ElevatedButton(
              // onPressed: 실행할 함수 연결
              onPressed: () {
                // Navigator.push: 새 화면 열기
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('새 화면 열기 (Button)'),
            ),
            
            const SizedBox(height: 20), // 버튼 사이 간격

            // [InkWell 활용 예시] 일반 위젯에 누르기 감지 + 물결 효과 추가
            InkWell(
              // onTap: 실행할 함수 연결
              onTap: () {
                // Navigator.push: 새 화면 열기
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('새 화면 열기 (InkWell)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. 새 화면 (이전 화면으로 돌아가기)
// ==========================================
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop: 이전 화면으로 돌아가기
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('이전 화면으로 돌아가기'),
        ),
      ),
    );
  }
}
