import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opusone_login/bloc/login.dart';
import 'package:opusone_login/home.dart';
import 'package:opusone_login/vanila/login.dart';

void main() {

  runApp(LoginApp());
}

class LoginApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      )],
      child: MaterialApp(
        initialRoute: "/bloc/login",
        routes: {
          '/vanila/login' : (context) => ValinilaLoginPage(),
          '/bloc/login' : (context) => LoginPage(),
          '/home' : (context) => HomePage(),
        },
      ),
    );
  }
}


