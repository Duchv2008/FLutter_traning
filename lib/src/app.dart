import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/screen/home_screen.dart';
import 'package:flutter_bloc_demo/src/screen/login_screen.dart';
import 'package:flutter_bloc_demo/src/events/authentication_event.dart';
import 'package:flutter_bloc_demo/src/screen/register_screen.dart';
import 'package:flutter_bloc_demo/src/states/authentication_state.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return BlocProvider<AuthenticationBloc>(builder: (context) {
      final authenticationBloc = AuthenticationBloc();
      authenticationBloc.dispatch(AppStarted());
      return authenticationBloc;
    }, child: MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case "/":
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (contextBloc, state) {
                    if (state is AuthenticationUninitialized) {
                      return Splash();
                    } else if (state is AuthenticationAuthenticated) {
                      return HomeScreen(userRepository);
                    } else if (state is AuthenticationUnAuthenticated) {
                      return LoginScreen(userRepository);
                    } else if (state is AuthenticationLoading) {
                      return LoadingIndicator();
                    } else {
                      return null;
                    }
                  },
                );
              case RegisterScreen.routeName:
                final arguments = settings.arguments;
                return RegisterScreen();
            }
          },
        );
      },
    ));
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Text("Splash"),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
}
