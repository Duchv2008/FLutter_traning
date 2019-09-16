import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/src/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register screen"),
      ),
      body: RegisterForm(),
    );
  }
}