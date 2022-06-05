import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:user_management_tool/models/Logger.dart';
import 'package:user_management_tool/models/OperationalLogAction.dart';
import 'package:user_management_tool/pages/AccountPage.dart';
import 'package:user_management_tool/pages/InfoPage.dart';
import 'package:user_management_tool/pages/UserListPage.dart';
import 'package:user_management_tool/providers/OperationalLogProvider.dart';
import 'package:user_management_tool/widgets/dialogs/LogoutDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    OperationalLogProvider.insert(Logger(action: OperationalLogAction.OPEN_HOME_PAGE));
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: page,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.blueGrey.shade100,
              selectedColor: Colors.blueGrey.shade50,
              selectedTitleTextStyle: const TextStyle(color: Colors.black),
              unselectedTitleTextStyle: const TextStyle(color: Colors.black54),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              // backgroundColor: Colors.blueGrey[700]
            ),
            title: Container(),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Account',
                onTap: () => page.jumpToPage(0),
                icon: const Icon(Icons.manage_accounts),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Users',
                onTap: () => page.jumpToPage(1),
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'About',
                onTap: () => page.jumpToPage(2),
                icon: const Icon(Icons.info),
              ),
              SideMenuItem(
                priority: 3,
                title: 'Logout',
                onTap: () => LogoutDialog().show(context),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                AccountPage(),
                UserListPage(),
                InfoPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
