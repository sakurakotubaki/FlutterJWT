import 'package:flutter/material.dart';
import 'package:jwt_auth/home_page.dart';
import 'package:jwt_auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // accessTokenを取得する
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;// main()で取得したtokenを受け取る

  MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token == null ? const LoginPage() : const HomePage(),// tokenがあればHomePage、なければLoginPageを表示
    );
  }
}
