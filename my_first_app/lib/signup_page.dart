import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final String email = _emailController.text;
                final String password = _passwordController.text;
                final String name = _nameController.text;
                try {
                  await context.read<AuthProvider>().signUp(email: email, password: password, name: name);
                  // Navigator.pushReplacementNamed(context, '/crud');
                  GoRouter.of(context).go('/crud');

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign Up failed: $e')));
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}


