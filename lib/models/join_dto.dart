class JoinDto{
  late String nick = '';
  late String email = '';
  late String password = '';
  late String rePassword = '';

  JoinDto({ required nick, required this.email, required this.password, required rePassword });

  Map<String, dynamic> toJson() => 
  {
    'nick': nick,
    'email': email,
    'password': password,
    're_password': rePassword
  };
}