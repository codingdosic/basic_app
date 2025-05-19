import 'package:basic_app/repositories/mongo_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/app_state.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({
    super.key
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // id 필드 
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  MongoUserRepository userRepository = MongoUserRepository();

  // 입력 필드 컨트롤러 메모리 해제
  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  // 로그인 처리
  Future<void> _handleLogin() async {

    await userRepository.handleLogin(context, _idController.text.trim(), _pwController.text.trim());

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
