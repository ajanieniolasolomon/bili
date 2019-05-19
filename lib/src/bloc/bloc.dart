import 'dart:async';
import '../vmixins/validate.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validate {
  final _emailController = new BehaviorSubject<String>();

  final _passwordController = new BehaviorSubject<String>();

//wmai

  Function get emailChange => _emailController.sink.add;

  Stream<String> get email => _emailController.stream
      .transform(emailTransform)
      .transform(emailTransforms);

//pwd



  Function get pwdChange => _passwordController.sink.add;

  Stream<String> get pwd => _passwordController.stream.transform(pwdTransform);

  Stream<bool> get submitVaild =>Observable.combineLatest2(email, pwd,(e,p)=>true);

  dispose() {
    _emailController.close();
    _passwordController.close();
  }

  submit(){
    final ValidEmail = _emailController.value;
    final ValidPwd =_passwordController.value;

    print(ValidEmail);
  }

}

