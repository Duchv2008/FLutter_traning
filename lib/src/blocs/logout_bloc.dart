import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/src/events/authentication_event.dart';
import 'package:flutter_bloc_demo/src/events/logout_event.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/states/logout_state.dart';

import 'authentication_bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LogoutBloc({
    this.userRepository,
    this.authenticationBloc
  });

  @override
  LogoutState get initialState => LogoutInitialized();

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is PressLogout) {
      try {
        authenticationBloc.dispatch(LoggedOut());
        await userRepository.logout();
        yield LogoutSuccess();
      } catch (err) {
        yield LogoutFail();
      }
    }
  }

  submitLogout() {
    this.dispatch(PressLogout());
  }
}