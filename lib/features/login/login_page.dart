import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/app_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // id 필드 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // 입력 필드 컨트롤러 메모리 해제
  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  // 로그인 처리
  void _handleLogin() {
    
    // 좌우 공백 제거 후 불러오기
    final username = _idController.text.trim();
    
    // 공백 시 종료
    if (username.isEmpty) return;

    // app_state의 변수에 저장
    context.read<AppState>().setUsername(username);
    
    // 현재 화면 종료하고 다음 라우트로 이동
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('로그인')),
      
      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          children: [

            const Text('Id'),

            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: '이름',
              ),
            ),

            const SizedBox(height: 20),

            const Text('Pw'),

            TextField(
              controller: _pwController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
