import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opusone_login/bloc/login.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('BloC')),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return  Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "이메일을 입력해주세요",
                      labelText: state.emailStatus == LoginStateStatus.INCORRECT ?  "잘못된 이메일 입니다" : "Email" ,
                    ),
                      onChanged: (text) => loginBloc.add(LoginEvent(
                          email: text,
                          password: state.password,
                          oldState: state,
                          uiEventType: UiEventType.EMAIL))),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: "패스워드를 입력해주세요",
                      labelText: state.passwordStatus ==  LoginStateStatus.INCORRECT ? "잘못된 패스워드 입니다": "Password"   ,
                    ),
                    onChanged: (text) => loginBloc.add(LoginEvent(
                          email: state.email,
                          password: text,
                          oldState: state,
                          uiEventType: UiEventType.PASSWORD))),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: OutlineButton(
                      child: Text('로그인'),
                      onPressed:
                          state.emailStatus == LoginStateStatus.CORRECT &&
                          state.passwordStatus == LoginStateStatus.CORRECT
                          ? () => Navigator.pushNamed(context, '/home')
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/vanila/login'),
        tooltip: 'Go to vanila',
        child: Icon(Icons.near_me),
      ),
    );
  }
}