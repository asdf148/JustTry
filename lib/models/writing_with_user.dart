import 'package:a_la_vez/models/user.dart';

class WritingWithUser {
  late int id;
  late String imagePath;
  late String title;
  late String content;
  late int personnel;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String period;
  late String category;
  late int userId;
  late User user;

  WritingWithUser.empty();

  WritingWithUser({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.content,
    required this.personnel,
    required this.createdAt,
    required this.updatedAt,
    required this.period,
    required this.category,
    required this.userId,
    required this.user,
  });

  factory WritingWithUser.fromJson(Map<String, dynamic> map) {

    return WritingWithUser(
      id: map["id"],
      imagePath: map["imagePath"],
      title: map["title"],
      content: map["content"],
      personnel: int.parse(map["personnel"]),
      createdAt: DateTime.parse(map["createdAt"]),
      updatedAt: DateTime.parse(map["updatedAt"]),
      period: map["period"],
      category: map["category"],
      userId: map['userId'],
      user: User.fromJson(map['user']),
    );
  }
}