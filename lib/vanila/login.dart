import 'package:flutter/material.dart';

class ValinilaLoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

typedef bool Predicate(String text);

class _LoginPageState extends State<ValinilaLoginPage> {
  String email = "";
  String password = "";
  _LoginStateStatus emailStatus = _LoginStateStatus.INIT;
  _LoginStateStatus passwordStatus = _LoginStateStatus.INIT;

  List<Predicate> emailRule = [
        (String email) => email.length > 10,
        (String email) => email.indexOf('@') >= 0,
  ];

  List<Predicate> passwordRule = [
        (String password) => password.length > 5,
  ];

  void _setCurrentState(String currentEmail, String currentPassword,_UiEventType type){
    _LoginStateStatus emailStatus;
    _LoginStateStatus passwordStatus;

    if (type == _UiEventType.EMAIL) {
      passwordStatus = this.passwordStatus;
      if (_checkRule(currentEmail, emailRule)) {
        emailStatus = _LoginStateStatus.CORRECT;
      } else {
        emailStatus = _LoginStateStatus.INCORRECT;
      }
    } else {
      emailStatus = this.emailStatus;
      if (_checkRule(password, passwordRule)) {
        passwordStatus = _LoginStateStatus.CORRECT;
      } else {
        passwordStatus = _LoginStateStatus.INCORRECT;
      }
    }
    setState(() {
      this.emailStatus = emailStatus;
      this.passwordStatus = passwordStatus;
      this.email = currentEmail;
      this.password = currentPassword;
    });
    debugPrint("$email $password $emailStatus $passwordStatus");
  }

  bool _checkRule(String text, List<Predicate> predicates) => predicates.where((predicate) => !predicate(text)).length == 0;
  bool _checkFirstAndNull(bool) => bool == null || bool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("바닐라"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "이메일을 입력해주세요",
                    labelText: this.emailStatus == _LoginStateStatus.INCORRECT ? "잘못된 이메일 입니다" :"Email" ,
                ),
                onChanged: (text) => this._setCurrentState(text, password, _UiEventType.EMAIL),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    hintText: "패스워드를 입력해주세요",
                    labelText: this.passwordStatus == _LoginStateStatus.INCORRECT  ? "잘못된 패스워드 입니다": "Password" ,
                ),
                onChanged: (text) => this._setCurrentState(email, text,_UiEventType.PASSWORD),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: OutlineButton(
                  child: Text('로그인'),
                  onPressed: this.emailStatus == _LoginStateStatus.CORRECT &&
                            this.passwordStatus == _LoginStateStatus.CORRECT
                        ? () => Navigator.pushNamed(context, '/home')
                        : null),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/bloc/login'),
        tooltip: 'Go to bloc',
        child: Icon(Icons.near_me),
      ),
    );
  }
}

enum _LoginStateStatus { INIT, CORRECT, INCORRECT }
enum _UiEventType{ EMAIL, PASSWORD }
