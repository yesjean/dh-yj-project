import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await authProvider.login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      GoRouter.of(context).go('/crud');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
                    }
                  },
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    context.go('/signup');
                  },
                  child: Text('Sign Up'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}