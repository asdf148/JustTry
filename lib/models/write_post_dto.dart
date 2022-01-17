class WritePostDto {
  late String title;
  late String content;
  late int personnel;
  late DateTime endDate;
  late String category;

  WritePostDto({
    required this.title,
    required this.content,
    required this.personnel,
    required this.endDate,
    required this.category,
  });

  Map<String, dynamic> toJson() => 
  {
    'title': title,
    'content': content,
    'personnel': personnel,
    'period': endDate.toString(),
    'category': category,
  };
}