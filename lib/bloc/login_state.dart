import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:opusone_login/bloc/login.dart';

typedef bool Predicate(String text);

class LoginState {
  String email = "";
  String password = "";
  LoginStateStatus emailStatus = LoginStateStatus.INIT;
  LoginStateStatus passwordStatus = LoginStateStatus.INIT;

  LoginState();

  LoginState.from(LoginEvent loginEvent)
      : this.email = loginEvent.email,
        this.password = loginEvent.password,
        this.emailStatus = loginEvent.oldState.emailStatus,
        this.passwordStatus = loginEvent.oldState.passwordStatus;
}
