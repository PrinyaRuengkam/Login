import 'package:flutter/material.dart';
import 'user_manager.dart';

class EditUsernamePage extends StatefulWidget {
  const EditUsernamePage({super.key});

  @override
  _EditUsernamePageState createState() => _EditUsernamePageState();
}

class _EditUsernamePageState extends State<EditUsernamePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _loadCurrentNames();
  }

  Future<void> _loadCurrentNames() async {
    final user = await UserManager.getUser(''); // Use an appropriate method to get current user info
    setState(() {
      _email = user?['email'];
      _password = user?['password'];
      _firstNameController.text = user?['firstName'] ?? '';
      _lastNameController.text = user?['lastName'] ?? '';
    });
  }

  Future<void> _saveNewNames() async {
    final newFirstName = _firstNameController.text;
    final newLastName = _lastNameController.text;

    if (_email != null && _password != null) {
      await UserManager.saveUser(
        email: _email!,
        firstName: newFirstName,
        lastName: newLastName,
        password: _password!,
      );
      Navigator.pop(context);
    } else {
      // Handle the case where email or password is null
      // For example, show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNewNames,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
