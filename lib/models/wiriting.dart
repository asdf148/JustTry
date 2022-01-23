class Writing{
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

  Writing.empty();

  Writing({
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
  });

  factory Writing.fromJson(Map<String, dynamic> map) {

    return Writing(
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
    );
  }
}