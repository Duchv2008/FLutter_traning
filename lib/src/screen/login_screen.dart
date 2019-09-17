import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/login_bloc.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/login_state.dart';
import 'package:flutter_bloc_demo/src/widgets/loading.dart';
import 'package:flutter_bloc_demo/src/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  UserRepository userRepository;

  LoginScreen(this.userRepository);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    return BlocProvider(
      builder: (context) {
        return LoginBloc(
            userRepository: widget.userRepository,
            authenticationBloc: authenticationBloc);
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text("Login screen"),
            ),
            body: LoginForm(),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, LoginState state) {
              return LoadingWidget(state is LoginLoading);
            },
          ),
        ],
      ),
    );
  }
}
