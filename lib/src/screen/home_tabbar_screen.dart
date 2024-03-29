import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_demo/src/blocs/logout_bloc.dart';
import 'package:flutter_bloc_demo/src/events/logout_event.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/logout_state.dart';

import 'account_screen.dart';

class HomeTabbarcreen extends StatelessWidget {
  final UserRepository userRepository;

  HomeTabbarcreen(this.userRepository);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of(context);
    final logoutBloc = LogoutBloc(
        userRepository: userRepository, authenticationBloc: authenticationBloc);
    return BlocProvider(builder: (context) {
      return logoutBloc;
    }, child: BlocBuilder<LogoutBloc, LogoutState>(
      builder: (context, LogoutState state) {
        return Container(
          color: Colors.white,
          child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: TabBarView(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                    ),
                    Container(
                      color: Colors.blue,
                    ),
                    AccountScreen()
                  ],
                ),
                bottomNavigationBar: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Colors.red,
                  tabs: <Widget>[
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: new Icon(Icons.rss_feed),
                    ),
                    Tab(
                      icon: new Icon(Icons.perm_identity),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
