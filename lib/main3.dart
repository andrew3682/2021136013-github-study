import 'package:flutter/material.dart';

// 프로필 머리말 위젯 샘플
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Row: 사진과 소개를 가로로 배치
    return Row(
      children: [
        
        // 2. CircleAvatar: 왼쪽 프로필 이미지
        const CircleAvatar(
          radius: 35, // 크기 조절
          backgroundImage: NetworkImage('https://picsum.photos'), // 샘플 이미지 주소
        ),
        
        // 3. SizedBox: 이미지와 글 사이 간격
        const SizedBox(width: 16.0),
        
        // 4. Expanded: 남은 폭을 소개 글에 전부 할당 (오버플로우 방지)
        Expanded(
          // 5. Column: 이름과 전공을 세로로 배치
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
            mainAxisSize: MainAxisSize.min, // 세로 크기를 내용만큼만 최소화
            children: const [
              Text(
                '홍길동', // 이름
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0), // 이름과 전공 사이의 미세한 간격
              Text(
                '컴퓨터공학과 / Flutter 전공', // 전공
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}

// 위에서 만든 머리말 위젯을 화면에 띄우기 위한 임시 틀입니다.
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('프로필 예제')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ProfileHeader(), // 조립한 프로필 머리말 실행
        ),
      ),
    ),
  );
}
