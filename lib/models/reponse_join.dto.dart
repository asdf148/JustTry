class ResponseJoinDto {
  late int id;
  late String nick;
  late String email;
  late String password;
  late String imagePath;

  ResponseJoinDto.empty();
  
  ResponseJoinDto({
    required this.id,
    required this.nick,
    required this.email,
    required this.password,
    required this.imagePath
  });
  
  factory ResponseJoinDto.fromJson(Map<String, dynamic> map) {
    return ResponseJoinDto(
        id: map['id'],
        nick: map['nick'],
        email: map['email'],
        password: map['password'],
        imagePath: map['imagePath']
    );
  }
}