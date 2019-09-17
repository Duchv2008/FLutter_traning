import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/src/events/login_event.dart';
import 'package:flutter_bloc_demo/src/resources/user_repository.dart';
import 'package:flutter_bloc_demo/src/validator/validation.dart';
import 'package:flutter_bloc_demo/src/states/login_state.dart';
import 'package:flutter_bloc_demo/src/blocs/authentication_bloc.dart';
import 'package:flutter_bloc_demo/src/events/authentication_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with ValidationMixin {
  UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.userRepository, this.authenticationBloc});

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(emailValidate);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidate);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) {
        return true;
      });

  Function(String) get changeEmail {
    return _emailController.sink.add;
  }

  Function(String) get changePassword {
    return _passwordController.sink.add;
  }

  submit() {
    final email = _emailController.value;
    final password = _passwordController.value;
    print("Submit login $email, $password");
    this.dispatch(PressLogin(email, password));
  }

  @override
  LoginState get initialState => LoginInitialized();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is PressLogin) {
      yield* _mapPressLoginToState(event);
    }
  }
  
  Stream<LoginState> _mapPressLoginToState(PressLogin event) async* {
    yield LoginLoading();
    try {
      print("LoginBloc ${event.email} ${event.password}");
      final loginResponse = await userRepository.authenticate(
          "eve.holt@reqres.in", "cityslicka");

      if (loginResponse != null && loginResponse.token != null) {
        authenticationBloc.dispatch(AppLoggedIn(token: loginResponse.token));
        yield LoginSuccess();
      } else {
        yield LoginFail("Token is null");
      }
    } on DioError catch(err) {
      yield LoginFail(err.message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.close();
    _passwordController.close();
  }
}
