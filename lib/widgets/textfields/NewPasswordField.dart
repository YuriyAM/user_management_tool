import 'package:flutter/material.dart';

class NewPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function setValidity;
  const NewPasswordField({
    Key? key,
    required this.controller,
    required this.setValidity,
  }) : super(key: key);
  @override
  _NewPasswordFieldState createState() => _NewPasswordFieldState();
}

class _NewPasswordFieldState extends State<NewPasswordField> {
  bool _showPassword = true;
  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  _isPasswordValid(String? password) {
    if (password == null || password.isEmpty || password.length < 8) {
      widget.setValidity(false);
      return "Password must be at least 8 characters long";
    } else if (!RegExp(
            r'^((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()<>/|\.,]).{8,})$')
        .hasMatch(password)) {
      widget.setValidity(false);
      return "Password must meet complexity requirements";
    } else {
      widget.setValidity(true);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _isPasswordValid(value),
      decoration: InputDecoration(
        hintText: "Enter new password",
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
