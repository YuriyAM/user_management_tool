import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_management_tool/pages/CreatePasswordPage.dart';
import 'package:user_management_tool/pages/InfoPage.dart';
import 'package:user_management_tool/pages/LoginPage.dart';
import 'package:user_management_tool/pages/UserListPage.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/pages/HomePage.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/users': (context) => const UserListPage(),
        '/info': (context) => const InfoPage(),
        '/change_password': (context) => const CreatePasswordPage(),
      },
    );
  }
}
