import 'package:flutter/material.dart';
import 'package:cron/cron.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_management_tool/pages/CreatePasswordPage.dart';
import 'package:user_management_tool/pages/InfoPage.dart';
import 'package:user_management_tool/pages/LoginPage.dart';
import 'package:user_management_tool/pages/UserListPage.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/pages/HomePage.dart';
import 'package:user_management_tool/widgets/dialogs/IdentificationDialog.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: ".env");
  // WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.init();
  final cron = Cron();
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    IdentificationDialog(navigatorKey);
  });
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
      navigatorKey: navigatorKey,
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
