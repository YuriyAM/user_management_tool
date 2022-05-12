import 'package:flutter/material.dart';

class ConfirmPasswordField extends StatefulWidget {
  final Function getPassword;
  final Function setValidity;
  const ConfirmPasswordField({
    Key? key,
    required this.getPassword,
    required this.setValidity,
  }) : super(key: key);
  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _showPassword = true;

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _checkPasswordMatch(String? password) {
    if (widget.getPassword() == password) {
      widget.setValidity(true);
      return null;
    } else {
      widget.setValidity(false);
      return "Passwords doesn't match";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _checkPasswordMatch(value),
      decoration: InputDecoration(
        hintText: "Confirm password",
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
