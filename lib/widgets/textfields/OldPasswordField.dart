import 'package:flutter/material.dart';
import 'package:user_management_tool/globals.dart';

class OldPasswordField extends StatefulWidget {
  final TextEditingController controller;
  const OldPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  _OldPasswordFieldState createState() => _OldPasswordFieldState();
}

class _OldPasswordFieldState extends State<OldPasswordField> {
  bool _showPassword = true;
  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _showPassword,
      decoration: InputDecoration(
        hintText: "Enter current password",
        // errorText: "Password must contain at least 1 special character"
        labelStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey.shade100),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          splashRadius: 20,
          onPressed: () => _toggleVisibility(),
        ),
      ),
    );
  }
}
