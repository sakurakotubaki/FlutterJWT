import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_auth/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ログインをするメソッド
  Future<void> login() async {
    // ログインAPIにリクエストを送る
    final response = await http.post(
      Uri.parse('http://localhost:3001/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': nameController.text,
        'password': passwordController.text,
      }),
    );
    // レスポンスを確認する
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("Response data: $responseData");
      // accessTokenがあればログイン成功
      if (responseData['accessToken'] != null) {  // ここを'accessToken'に変更
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['accessToken'] as String); // ここも'accessToken'に変更
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        print('Login Success');
        // ログイン失敗
      } else if (responseData['message'] != null) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(responseData['message'] as String),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      } else {
        print('Login Error: Unexpected response'); // エラーメッセージを追加
      }
    } else {
      print('HTTP Error with code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
