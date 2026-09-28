import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Windows Calculator Style',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF202020),
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = '0';
  String _input = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';
  bool _isNewInput = true;

  // 버튼 클릭 이벤트 처리
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _input = '';
        _num1 = 0;
        _num2 = 0;
        _operand = '';
        _isNewInput = true;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
        _num1 = double.tryParse(_output) ?? 0;
        _operand = buttonText;
        _isNewInput = true;
      } else if (buttonText == '=') {
        _num2 = double.tryParse(_output) ?? 0;
        if (_operand == '+') {
          _output = (_num1 + _num2).toString();
        } else if (_operand == '-') {
          _output = (_num1 - _num2).toString();
        } else if (_operand == '×') {
          _output = (_num1 * _num2).toString();
        } else if (_operand == '÷') {
          if (_num2 == 0) {
            _output = 'Error';
          } else {
            _output = (_num1 / _num2).toString();
          }
        }
        // 소수점 이하가 .0인 경우 정수형태로 보기 좋게 정리
        if (_output.endsWith('.0')) {
          _output = _output.substring(0, _output.length - 2);
        }
        _operand = '';
        _isNewInput = true;
      } else {
        // 숫자 및 소수점 입력
        if (_isNewInput) {
          _output = buttonText;
          _isNewInput = false;
        } else {
          if (_output == '0' && buttonText != '.') {
            _output = buttonText;
          } else {
            _output += buttonText;
          }
        }
      }
    });
  }

  // 계산기 버튼 위젯 빌더
  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xFF3B3B3B),
            foregroundColor: textColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24.0),
          ),
          onPressed: () => _buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계산기'),
        backgroundColor: const Color(0xFF2D2D2D),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 결과 디스플레이 영역
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          // 키패드 영역 (윈도우 계산기 스타일)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', color: const Color(0xFF4A4A4A), textColor: Colors.orangeAccent),
                    _buildButton('÷', color: const Color(0xFF4A4A4A)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×', color: const Color(0xFF4A4A4A)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: const Color(0xFF4A4A4A)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: const Color(0xFF4A4A4A)),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('=', color: Colors.blueAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}