class Validate {
  String _userName = 'ayman';
  String _password = 'Shams';

bool validateCredintials(String username,String password){
  return username == _userName && password ==_password;
}



}