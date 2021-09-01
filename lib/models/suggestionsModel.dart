class Suggestion {
  String title, content, username;
  Suggestion(
      {required this.title, required this.content, required this.username});
  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      title: json["title"] ?? "No title",
      content: json["content"] ?? "No content",
      username: json["username"] ?? "Anonymous",
    );
  }
}
