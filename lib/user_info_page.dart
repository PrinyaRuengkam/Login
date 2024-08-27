import 'package:flutter/material.dart';
import 'package:login/login_page.dart';
import 'package:login/token_manager.dart';
import 'user_manager.dart';
import 'edit_username_page.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String? _email;
  String? _firstName;
  String? _lastName;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = await UserManager.getUser(''); // Use an appropriate method to get current user info
    setState(() {
      _email = user?['email'];
      _firstName = user?['firstName'];
      _lastName = user?['lastName'];
    });
  }

  Future<void> _logout() async {
    await TokenManager.deleteToken(); // Implement token deletion
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Center(
        child: _email == null || _firstName == null || _lastName == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Email: $_email',
                      style: const TextStyle(
                        fontSize: 24, // ขนาดตัวอักษร
                        fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Full Name: $_firstName $_lastName',
                      style: const TextStyle(
                        fontSize: 24, // ขนาดตัวอักษร
                        fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditUsernamePage(),
                          ),
                        ).then((_) => _loadUserInfo()); // Reload user info after editing
                      },
                      child: const Text('Edit Username'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _logout,
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
