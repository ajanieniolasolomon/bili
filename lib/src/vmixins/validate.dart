import 'dart:async';



class Validate{
  final emailTransform = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains('@')){
        sink.add(email);
      }else{
        sink.addError('Enter a valide email');
      }
    }

  );
  final emailTransforms = StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink){
        if(email.contains('.')){
          sink.add(email);
        }else{
          sink.addError('Enter a valide email');
        }
      }

  );


  final pwdTransform = new StreamTransformer<String, String>.fromHandlers(
    handleData: (pwd,sink){
      if(pwd.length > 4){
        sink.add(pwd);
      }
      else{
        sink.addError('Password to short');
      }
    }
  );
}