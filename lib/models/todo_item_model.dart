class TodoItem {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  TodoItem({required this.id, required this.title, this.description = "", this.isCompleted = false});

  void toggleTodoStatus() {
    isCompleted = !isCompleted;
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1: 0
    };
  }

  @override
  String toString() {
    return 'Dog{title: $title, description: $description, isCompleted: $isCompleted}';
  }

  factory TodoItem.fromJson(Map data) => TodoItem(
        id: data['id'],
        title: data['title'],
        description : data['description'],
        isCompleted : data['isCompleted'] == 0 ? false: true
    );
}

enum DropdownMenuValues {
  all("All"),
  completed("Completed"),
  pending("Pending");

  final String name;
  const DropdownMenuValues( this.name);
}