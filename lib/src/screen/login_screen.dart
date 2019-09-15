import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/login_bloc.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/login_state.dart';
import 'package:flutter_bloc_demo/src/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  UserRepository userRepository;

  LoginScreen(this.userRepository);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login screen"),
      ),
      body: BlocProvider(
          builder: (context) {
            return LoginBloc(userRepository: userRepository,
                authenticationBloc: authenticationBloc);
          },
          child: LoginForm(),

      )
    );
  }
}