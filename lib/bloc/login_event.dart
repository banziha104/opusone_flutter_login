import 'package:opusone_login/bloc/login.dart';

class LoginEvent {
  String email;
  String password;
  LoginState oldState;
  UiEventType uiEventType;
  LoginEvent({this.email, this.password, this.oldState, this.uiEventType});
}

enum UiEventType{
  EMAIL,
  PASSWORD
}
