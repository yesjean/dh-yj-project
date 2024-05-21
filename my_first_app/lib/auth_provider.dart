import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthProvider extends ChangeNotifier {
  late Database _database;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _initDatabase();
  }

  // Future<void> _initDatabase() async {
  //   _database = await openDatabase(
  //     join(await getDatabasesPath(), 'user_database.db'),
  //     onCreate: (db, version) {
  //       return db.execute(
  //         'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
  //       );
  //     },
  //     version: 1,
  //   );
  // }
Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      version: 2, // 데이터베이스 버전을 2로 올립니다.
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute('DROP TABLE IF EXISTS users');
          await db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
          );
        }
      },
    );
  }
  Future<void> signUp({required String name, required String email, required String password}) async {
    try {
      await _database.insert(
        'users', // 테이블 이름을 'users'로 변경
        {'name': name, 'email': email, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print('Error signing up: $e');
      throw Exception('Sign Up failed');
    }
  }

  Future<void> login({required String email, required String password}) async {
    final List<Map<String, dynamic>> users = await _database.query(
      'users', // 테이블 이름을 'users'로 변경
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (users.isNotEmpty) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Login failed');
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
