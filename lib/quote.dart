class Quote{
  String author;
  String text;
  bool found = false;

  Quote({required this.author, required this.text});

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'text': text,
      'found': found,
    };
  }
}