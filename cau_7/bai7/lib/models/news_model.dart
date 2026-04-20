class NewsModel {
  final String id;
  final String title;
  final String content;

  NewsModel({required this.id, required this.title, required this.content});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}