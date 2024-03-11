

import 'package:flutter/cupertino.dart';
import 'models/todo_item_model.dart';

class AppStateNotifier extends ChangeNotifier {

  AppStateNotifier();

  List<TodoItem> todoList = [];
  DropdownMenuValues filterValue = DropdownMenuValues.all;

  void changeFilterValue(DropdownMenuValues value) {
      filterValue = value;
      notifyListeners();
  }

  void toggleTodoStatus(TodoItem todoObj) {
    todoObj.toggleTodoStatus();
    notifyListeners();
  }

  void createNewTodo(TodoItem todoItem) {
    todoList.add(todoItem);
    print("My todo : $todoList");
    notifyListeners();
  }

  void deleteTodoItem(TodoItem todoItem) {
    todoList.remove(todoItem);
    notifyListeners();
  }

  void editTodoItem(TodoItem todoItem, int index) {
    todoList.replaceRange(index, index + 1, [todoItem]);
    notifyListeners();
  }

}