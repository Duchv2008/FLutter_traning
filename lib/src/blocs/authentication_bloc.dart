import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/Utils/app_security.dart';
import 'package:flutter_bloc_demo/src/events/authentication_event.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository = UserRepository();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final appSecurity =  await AppSecurity.getInstance();
      final bool hasToken = await appSecurity.hasToken();
      print("hasToken $hasToken");
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnAuthenticated();
      }
    }

    if (event is AppLoggedIn) {
      yield AuthenticationLoading();
      await Future.delayed(Duration(seconds: 4));
      final appSecurity =  await AppSecurity.getInstance();
      final _ = await appSecurity.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await Future.delayed(Duration(seconds: 2));
      final appSecurity =  await AppSecurity.getInstance();
      final _ = await appSecurity.deleteToken();
      yield AuthenticationUnAuthenticated();
    }
  }
}