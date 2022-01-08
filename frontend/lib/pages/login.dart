import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:frontend/services/api.dart';

class LoginScreen extends StatelessWidget {
  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Api().login(data.name, data.password).then((value) => value);
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint(
        'Signup Name: ${data.name}, Password: ${data.password}, Username: ${data.additionalSignupData?['username']}');
    return Api()
        .register(
          email: data.name,
          password: data.password,
          name: data.additionalSignupData?['username'],
        )
        .then((value) => value);
  }

  Future<String?> _recoverPassword(String email) {
    debugPrint('email: $email');
    return Api().resetPassword(email).then((value) => value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'OffSide',
      onLogin: _authUser,
      additionalSignupFields: const [UserFormField(keyName: "username")],
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.pop(context);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
