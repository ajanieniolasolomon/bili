
class ValidateMixin{


  String validateEmail(String value){
    if(value.length < 4){
      return 'challenge too short';
    }
    return null;
  }


  String validatePwd(String value){
    if(value.length < 6){
      return 'invalid password';
    }
    return null;
  }
}