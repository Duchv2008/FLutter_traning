import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/logout_bloc.dart';
import 'package:flutter_bloc_demo/src/widgets/register_form.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = "/account";

  @override
  Widget build(BuildContext context) {
    final LogoutBloc logoutBloc = BlocProvider.of(context);
    return Scaffold(
        body: SafeArea(
          child: RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              logoutBloc.submitLogout();
            }),
      )
    );
  }
}
