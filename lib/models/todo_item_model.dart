class TodoItem {
  final String title;
  final String description;
  bool isCompleted = false;

  TodoItem({required this.title, this.description = ""});

  void toggleTodoStatus() {
    isCompleted = !isCompleted;
  }
}

enum DropdownMenuValues {
  all("All"),
  completed("Completed"),
  pending("Pending");

  final String name;
  const DropdownMenuValues( this.name);
}