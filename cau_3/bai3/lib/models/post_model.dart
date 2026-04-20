class PostModel {
  final String title;
  final String body;

  PostModel({required this.title, required this.body});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}