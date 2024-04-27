

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'models/todo_item_model.dart';

class AppStateNotifier extends ChangeNotifier {
  dynamic box;
  AppStateNotifier();

  List<TodoItem> todoList = [];
  DropdownMenuValues filterValue = DropdownMenuValues.all;

  openDbAndReadTodoList() async {
    await Hive.openBox<TodoItem>('todoList');
    box = Hive.box<TodoItem>('todoList');
    todoList = box.values.toList().cast<TodoItem>();
  }

  void changeFilterValue(DropdownMenuValues value) {
      filterValue = value;
      notifyListeners();
  }

  void toggleTodoStatus(TodoItem todoObj, int index) {
    todoObj.toggleTodoStatus();
    editTodoItem(todoObj, index);
    notifyListeners();
  }

  Future<void> createNewTodo(TodoItem todoItem) async {
    await box.add(todoItem);
    todoList = Hive.box<TodoItem>('todoList').values.toList().cast<TodoItem>();
    print("My todo : $todoList");
    notifyListeners();
  }

  Future<void> deleteTodoItem(TodoItem todoItem, int index) async {
    await box.deleteAt(index);
    todoList = Hive.box<TodoItem>('todoList').values.toList().cast<TodoItem>();
    notifyListeners();
  }

  Future<void> editTodoItem(TodoItem todoItem, int index) async {
    await box.putAt(index, todoItem);
    todoList = Hive.box<TodoItem>('todoList').values.toList().cast<TodoItem>();
    notifyListeners();
  }

}