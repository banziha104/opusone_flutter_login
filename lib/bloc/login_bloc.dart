import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  List<Predicate> emailRule = [
        (String email) => email.length > 10,
        (String email) => email.indexOf('@') >= 0,
  ];

  List<Predicate> passwordRule = [
        (String password) => password.length > 5,
  ];

  bool _checkRule(String text, List<Predicate> predicates) => predicates.where((predicate) => !predicate(text)).length == 0;

  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    var newState = LoginState.from(event);

    bool isEmailValidated = _checkRule(event.email, emailRule);
    bool isPasswordValidated = _checkRule(event.password, passwordRule);

    if (event.uiEventType == UiEventType.EMAIL) {
      if (isEmailValidated) {
        newState.emailStatus = LoginStateStatus.CORRECT;
      } else {
        newState.emailStatus = LoginStateStatus.INCORRECT;
      }
    } else if (event.uiEventType == UiEventType.PASSWORD) {
      if (isPasswordValidated) {
        newState.passwordStatus = LoginStateStatus.CORRECT;
      } else {
        newState.passwordStatus = LoginStateStatus.INCORRECT;
      }
    }
    debugPrint("${newState.emailStatus} ${newState.passwordStatus} |${newState.email}|${newState.password}|");

    yield newState;
  }


}

enum LoginStateStatus { INIT, CORRECT, INCORRECT }