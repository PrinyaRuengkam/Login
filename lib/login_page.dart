import 'package:flutter/material.dart';
import 'package:login/token_manager.dart';
import 'user_manager.dart';
import 'sign_up_page.dart'; // Import page for sign up
import 'user_info_page.dart'; // Import page for user info

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _loginError;
  bool _emailError = false;
  bool _passwordError = false;

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _loginError = null;
      _emailError = email.isEmpty;
      _passwordError = password.isEmpty;
    });

    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) _emailError = true;
      if (password.isEmpty) _passwordError = true;
      setState(() {});
      return;
    }

    final user = await UserManager.getUser(email);
    if (user != null && user['password'] == password) {
      await TokenManager.saveToken('dummy_token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const UserInfoPage(),
        ),
      );
    } else {
      setState(() {
        _loginError = 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // เพิ่มช่องว่างระหว่างข้อความและฟิลด์กรอกข้อมูล
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorText: _emailError ? 'กรุณากรอกอีเมล' : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                errorText: _passwordError ? 'กรุณากรอกรหัสผ่าน' : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            if (_loginError != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _loginError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(), // Navigate to sign up page
                  ),
                );
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
