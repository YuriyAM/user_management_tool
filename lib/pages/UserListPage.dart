import 'package:flutter/material.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/widgets/dialogs/CreateUserDialog.dart';
import 'package:user_management_tool/widgets/cards/UserCard.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  _buildItem(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: UserCard(user: user, notifyParent: () => setState(() {})),
    );
  }

  _addUser() async {
    await showDialog<dynamic>(
      context: context,
      builder: (_) => const CreateUserDialog(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: FutureBuilder<List>(
        future: DatabaseProvider.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('Cannot retrieve data from database'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    _buildItem(snapshot.data![index]),
                itemCount: snapshot.data!.length,
              );
            }
          } else if (snapshot.hasError) {
            return const Text('Error'); // error
          } else {
            return const CircularProgressIndicator(); // loading
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _addUser(),
      ),
    );
  }
}
