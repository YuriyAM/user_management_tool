import 'package:flutter/material.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class DeleteUserButton extends StatefulWidget {
  final User user;
  final Function notifyParent;

  const DeleteUserButton({
    Key? key,
    required this.user,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _DeleteUserButtonState createState() => _DeleteUserButtonState();
}

class _DeleteUserButtonState extends State<DeleteUserButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => _deleteUser(),
      child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.6), shape: BoxShape.circle),
          child: const Icon(Icons.delete_forever)),
    );
  }

  _deleteUser() async {
    await DatabaseProvider.deleteUser(widget.user);
    widget.notifyParent();

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // Shows the information on Snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(milliseconds: 3000),
      backgroundColor: Colors.white.withOpacity(0.95),
      content: Text("User «${widget.user.username}» deleted successfully",
          style: const TextStyle(color: Colors.black, fontSize: 14)),
    ));
  }
}
