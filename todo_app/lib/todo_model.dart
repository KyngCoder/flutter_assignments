class Todo {
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Todo &&
        runtimeType == other.runtimeType &&
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      description: map['description'],
    );
  }

    @override
  String toString() {
    return 'Todo: {title: $title, description: $description}';
  }
}
