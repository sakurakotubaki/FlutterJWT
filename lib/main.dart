import 'package:flutter/material.dart';
import 'package:jwt_auth/home_page.dart';
import 'package:jwt_auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokenAsyncValue = ref.watch(tokenProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tokenAsyncValue.when(
        data: (token) => token == null ? const LoginPage() : const HomePage(),
        loading: () => const CircularProgressIndicator(),
        error: (e, stack) => Text('Error: $e'),
      ),
    );
  }
}

/// [StatefulWidget]を使う場合
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // accessTokenを取得する
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('token');
//   runApp(MyApp(token: token));
// }

// class MyApp extends StatelessWidget {
//   final String? token;// main()で取得したtokenを受け取る

//   MyApp({Key? key, this.token}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: token == null ? const LoginPage() : const HomePage(),// tokenがあればHomePage、なければLoginPageを表示
//     );
//   }
// }
