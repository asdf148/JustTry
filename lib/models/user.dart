class User {
  final int userId;
  final String name;
  final String email;
  final String password;
  final String imagePath;
  
  User({required this.userId, required this.name, required this.email, required this.password, required this.imagePath});
  
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        userId: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        imagePath: map['imagePath'],
    );
  }
}