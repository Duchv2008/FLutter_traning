import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/logout_bloc.dart';
import 'package:flutter_bloc_demo/src/events/logout_event.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/logout_state.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

  HomeScreen(this.userRepository);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    final logoutBloc = LogoutBloc(userRepository: userRepository,
        authenticationBloc: authenticationBloc);
    return BlocProvider(
      builder: (context) {
        return logoutBloc;
      },
      child: BlocBuilder<LogoutBloc, LogoutState>(
        builder: (context, LogoutState state) {
          return Scaffold(
            bottomNavigationBar: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home",
                ),
                
              ],
            ),
            body: RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                logoutBloc.submitLogout();
              },
            ),
          );
        },
      )
    );
  }
}