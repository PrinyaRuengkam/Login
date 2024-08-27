import 'package:flutter/material.dart';
import 'sign_up_page.dart'; // นำเข้าหน้าสมัครสมาชิก
import 'login_page.dart'; // นำเข้าหน้าล็อกอิน
import 'user_info_page.dart'; // นำเข้าหน้าข้อมูลผู้ใช้
import 'edit_username_page.dart'; // นำเข้าหน้าการแก้ไขชื่อผู้ใช้

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // ตั้งค่าเส้นทางเริ่มต้น
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/user-info': (context) => const UserInfoPage(),
        '/edit-username': (context) => const EditUsernamePage(),
      },
    );
  }
}
