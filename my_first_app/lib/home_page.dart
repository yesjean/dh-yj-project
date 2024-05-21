import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  auth.logout();
                },
              ),
            ],
          ),
          body: Center(
            child: Text('Welcome to Home Page'),
          ),
        );
      },
    );
  }
}
