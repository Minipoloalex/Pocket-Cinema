class News {
  final String title;
  final String description;
  final String image;
  final String date;

  News({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      date: json['date'],
    );
  }
}
