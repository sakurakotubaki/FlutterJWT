import 'package:flutter/material.dart';
import 'package:jwt_auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // ログアウトをするメソッド
  Future<void> logout(BuildContext context) async {
    // accessTokenを削除して、ログイン画面に戻る
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text('You are logged in!'),
      ),
    );
  }
}
