import 'package:flutter/material.dart';
import 'package:my_first_app/web_view_page.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'crud_page.dart';
import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/crud',
        builder: (context, state) => CrudPage(),
      ),
        GoRoute(
        path: '/web',
        builder: (context, state) => WebViewExample(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
