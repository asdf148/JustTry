class LoginDto{
  String email;
  String password;

  LoginDto({ required this.email, required this.password });

  Map<String, dynamic> toJson() => 
  {
    'email': email,
    'password': password,
  };
}