import 'package:flutter/material.dart';
import 'package:user_management_tool/models/User.dart';
import 'package:user_management_tool/providers/DatabaseProvider.dart';

class LockUserButton extends StatefulWidget {
  final User user;
  final Function notifyParent;

  const LockUserButton({
    Key? key,
    required this.user,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _LockUserButtonState createState() => _LockUserButtonState();
}

class _LockUserButtonState extends State<LockUserButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => _lockUser(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: widget.user.enabled!
                ? const Color(0xFF14CFA2).withOpacity(0.6)
                : Colors.transparent,
            shape: BoxShape.circle),
        child: widget.user.enabled!
            ? const Icon(Icons.lock_open)
            : const Icon(Icons.lock),
      ),
    );
  }

  _lockUser() async {
    widget.user.enable();
    await DatabaseProvider.updateUser(widget.user);
    setState(() {});
  }
}
