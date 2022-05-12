import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/widgets/buttons/DeleteUserButton.dart';
import 'package:user_management_tool/widgets/buttons/LockUserButton.dart';
import 'package:user_management_tool/widgets/dialogs/EditUserDialog.dart';

class UserCard extends StatefulWidget {
  final User user;
  final Function notifyParent;

  const UserCard({Key? key, required this.user, required this.notifyParent})
      : super(key: key);
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: () => CURRENT_USER!.privileged! ? _editUser() : null,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.account_box,
                    size: 50,
                    color: Colors.blue,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.user.username}\n",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        // color: Colors.white,
                      ),
                    ),
                    Text(
                      "Role: ${widget.user.privileged! ? 'Admin' : 'User'}\n",
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        // color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: CURRENT_USER!.privileged!,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: LockUserButton(
                        notifyParent: () => widget.notifyParent(),
                        user: widget.user,
                      ))),
              Visibility(
                  visible: CURRENT_USER!.privileged!,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: DeleteUserButton(
                        notifyParent: () => widget.notifyParent(),
                        user: widget.user,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  _editUser() async {
    final user = await showDialog<dynamic>(
        context: context, builder: (_) => EditUserDialog(user: widget.user));
    setState(() {});
  }
}
