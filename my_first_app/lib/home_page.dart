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
             child: ElevatedButton(
              onPressed: () {
                // 웹뷰 페이지로 이동합니다.
                GoRouter.of(context).go('/web');
              },
              child: Text('Open WebView'),
            ),
          ),
        );
      },
    );
  }
}
