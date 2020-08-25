import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:opusone_login/bloc/login.dart';

typedef bool Predicate(String text);

class LoginState {
  String email = "";
  String password = "";
  LoginStateStatus emailStatus = LoginStateStatus.INIT;
  LoginStateStatus passwordStatus = LoginStateStatus.INIT;
  List<Predicate> emailRule = [
    (String email) => email.length > 10,
    (String email) => email.indexOf('@') >= 0,
  ];

  List<Predicate> passwordRule = [
    (String password) => password.length > 5,
  ];

  LoginState();

  LoginState.from(LoginEvent loginEvent)
      : this.email = loginEvent.email,
        this.password = loginEvent.password,
        this.emailStatus = loginEvent.oldState.emailStatus,
        this.passwordStatus = loginEvent.oldState.passwordStatus {
    bool isEmailValidated = _checkRule(email, emailRule);
    bool isPasswordValidated = _checkRule(password, passwordRule);

    if (loginEvent.uiEventType == UiEventType.EMAIL) {
      if (isEmailValidated) {
        this.emailStatus = LoginStateStatus.CORRECT;
      } else {
        this.emailStatus = LoginStateStatus.INCORRECT;
      }
    } else if (loginEvent.uiEventType == UiEventType.PASSWORD) {
      if (isPasswordValidated) {
        this.passwordStatus = LoginStateStatus.CORRECT;
      } else {
        this.passwordStatus = LoginStateStatus.INCORRECT;
      }
    }
    debugPrint("$emailStatus $passwordStatus |$email|$password|");
  }

  bool _checkRule(String text, List<Predicate> predicates) =>
      predicates.where((predicate) => !predicate(text)).length == 0;
}

enum LoginStateStatus { INIT, CORRECT, INCORRECT }
