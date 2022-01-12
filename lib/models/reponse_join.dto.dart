class ResponseJoinDto {
  final String nick;
  final String email;
  final String password;
  
  ResponseJoinDto({required this.nick, required this.email, required this.password});
  
  factory ResponseJoinDto.fromJson(Map<String, dynamic> map) {
    return ResponseJoinDto(
        nick: map['nick'],
        email: map['email'],
        password: map['password'],
    );
  }
}