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
    // if(map["imagePath"] == null ){
    //   return WritingWithUser(
    //     id: map["id"],
    //     imagePath: "",
    //     title: map["title"],
    //     content: map["content"],
    //     personnel: map["personnel"],
    //     createdAt: DateTime.parse(map["createdAt"]),
    //     updatedAt: DateTime.parse(map["updatedAt"]),
    //     period: map["period"],
    //     category: map["category"],
    //     userId: map['userId'],
    //     user: User.fromJson(map['user']),
    //   );
    // }
    return WritingWithUser(
      id: map["id"],
      imagePath: map["imagePath"],
      title: map["title"],
      content: map["content"],
      personnel: map["personnel"],
      createdAt: DateTime.parse(map["createdAt"]),
      updatedAt: DateTime.parse(map["updatedAt"]),
      period: map["period"],
      category: map["category"],
      userId: map['userId'],
      user: User.fromJson(map['user']),
    );
  }
}
/*
{
  writing: {
    title: asdf,
    content: zxcv,
    personnel: 8,
    category: all,
    user: {
      id: 135,
      nick: qwer,
      email: qwer@qwer.com,
      password:$2b$12$xZBhb2EP6kKFVPG7y7doVeWaAeApmhjIeFi8rKrsqBCXkIVpLY62G,
      imagePath: 1642342700934__image_picker_CDAFD180-0395-420E-BAA8-D9CA5A4929F6-12604-0000002A033257B9.jpg
    }, 
    userId: 135,
    imagePath: null, 
    id: 495,
    createdAt: 2022-01-20T03:37:45.189Z,
    updatedAt: 2022-01-20T03:37:45.189Z
  }
}
*/