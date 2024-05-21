import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'auth_provider.dart';
import 'web_view_page.dart';
import 'package:go_router/go_router.dart';

class CrudPage extends StatefulWidget {
  @override
  _CrudPageState createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  late Database _database;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int? _selectedUserId;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

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
    _getUsers();
  }

  Future<void> _insertUser(String name, String email, String password) async {
    await _database.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _getUsers();
  }

  Future<void> _getUsers() async {
    final List<Map<String, dynamic>> users = await _database.query('users');
    setState(() {
      _users = users;
    });
  }

  Future<void> _updateUser(int id, String name, String email, String password) async {
    await _database.update(
      'users',
      {'name': name, 'email': email, 'password': password},
      where: 'id = ?',
      whereArgs: [id],
    );
    _getUsers();
  }

  Future<void> _deleteUser(int id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              GoRouter.of(context).go('/');
            },
          ),
          ElevatedButton(
          onPressed: () {
            GoRouter.of(context).go('/web');
          },
          child: Text('Open WebView'),
        ),

        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _insertUser(_nameController.text, _emailController.text, _passwordController.text);
              _nameController.clear();
              _emailController.clear();
              _passwordController.clear();
            },
            child: Text('Add User'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_selectedUserId != null) {
                await _updateUser(_selectedUserId!, _nameController.text, _emailController.text, _passwordController.text);
                _nameController.clear();
                _emailController.clear();
                _passwordController.clear();
              }
            },
            child: Text('Update User'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_selectedUserId != null) {
                await _deleteUser(_selectedUserId!);
                _selectedUserId = null;
                _nameController.clear();
                _emailController.clear();
                _passwordController.clear();
              }
            },
            child: Text('Delete User'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                  onTap: () {
                    setState(() {
                      _selectedUserId = user['id'];
                      _nameController.text = user['name'];
                      _emailController.text = user['email'];
                      _passwordController.text = user['password'];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
