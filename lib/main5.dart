import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});
}

class _TodoScreenState extends State<TodoScreen> {
  final List<TodoItem> _todoList = [
    TodoItem(title: "5주차 강의 복습"),
    TodoItem(title: "상태 흐름도 작성"),
  ];

  int get _remainingTodoCount => _todoList.where((item) => !item.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: const Color(0xFF0D253F),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "나의 할 일",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111111),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    "남은 할 일 ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF555555),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "$_remainingTodoCount",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A86B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _todoList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _todoList[index];
                  
                  // 💡 각 아이템 개별 제어를 위해 개별 위젯 추출 대신 주입 형태로 구성
                  return BounceTodoTile(
                    item: item,
                    onToggle: () {
                      setState(() {
                        item.isCompleted = !item.isCompleted;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 💡 찰진 통통 튀기기 효과를 전담하는 개별 리스트 아이템 위젯입니다.
class BounceTodoTile extends StatefulWidget {
  final TodoItem item;
  final VoidCallback onToggle;

  const BounceTodoTile({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  State<BounceTodoTile> createState() => _BounceTodoTileState();
}

class _BounceTodoTileState extends State<BounceTodoTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // 💡 애니메이션 컨트롤러 설정 (0.4초 동안 작동)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // 💡 중요! Curves.elasticOut 크기 곡선을 사용하여 스프링처럼 탱글탱글 튕기게 만듭니다.
    // 1.0(정상 크기)에서 시작해서 1.12배까지 확 커졌다가 띠용~ 하면서 제자리로 옵니다.
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playBounce() {
    // 💡 클릭 시 트윈의 끝값을 1.12배(확 커짐)로 순간 세팅하고 애니메이션을 재생합니다.
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _controller.forward(from: 0.0).then((_) {
      // 애니메이션이 끝나면 부드럽게 원래 크기인 1.0으로 리셋합니다.
      _scaleAnimation = Tween<double>(begin: 1.12, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: widget.item.isCompleted ? const Color(0xFFE8F7F0) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.item.isCompleted ? const Color(0xFF00A86B) : const Color(0xFFEEEEEE),
            width: widget.item.isCompleted ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.item.isCompleted ? Icons.check : Icons.circle_outlined,
              size: 18,
              color: widget.item.isCompleted ? const Color(0xFF00A86B) : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: widget.item.isCompleted ? Colors.grey : const Color(0xFF333333),
                  decoration: widget.item.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _playBounce(); // 💡 통통 튀기기 효과 발동!
                widget.onToggle(); // 데이터 상태 변경
              },
              child: Text(
                widget.item.isCompleted ? "취소" : "완료",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: widget.item.isCompleted ? const Color(0xFF888888) : const Color(0xFF3AAFA9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
