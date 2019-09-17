import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/login_bloc.dart';
import 'package:flutter_bloc_demo/src/states/login_state.dart';
import 'package:flutter_bloc_demo/src/events/login_event.dart';

//  typedef CallBackLogin = Function(bool isLoading);
//  bool _isTestLoading;
//  CallBackLogin _callBackLogin;
//  LoginForm(bool isTestLoading, {CallBackLogin callBackLogin}) {
//    this._isTestLoading = isTestLoading;
//    this._callBackLogin = callBackLogin;
//  }

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of(context);
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, LoginState state) {
        if (state is LoginFail) {
          _showAlert(context, state.message);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: loginBloc,
        builder: (context, LoginState state) {
          return Container(
            child: Column(
              children: <Widget>[
                emailTextField(loginBloc),
                passwordTextField(loginBloc),
                submitButton(state, loginBloc),
                Container(
                  child: redirectRegisterScreen(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              )
            ]);
      },
    );
  }

  Widget emailTextField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
              hintText: "email@gmail.com",
              labelText: "Email",
              errorText: snapshot.error),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordTextField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              errorText: snapshot.error),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(LoginState state, LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        final canPressBtn = !(state is LoginLoading) && snapshot.hasData;
        return RaisedButton(
          child: Text("Login"),
          color: Colors.pink,
          disabledColor: Colors.black12,
          onPressed: canPressBtn ? bloc.submit : null,
        );
      },
    );
  }

  Widget redirectRegisterScreen(BuildContext context) {
    return RaisedButton(
      child: Text("Register"),
      color: null,
      onPressed: () {
        Navigator.pushNamed(context, "/register",
            arguments: {"test": "Test arguments"});
        // Navigator.pushNamed(context, "/register");
      },
    );
  }
}
