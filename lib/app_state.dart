

import 'package:flutter/foundation.dart';
import 'db.dart';
import 'models/todo_item_model.dart';

class AppStateNotifier extends ChangeNotifier {

  AppStateNotifier();

  List<TodoItem> todoList = [];
  DropdownMenuValues filterValue = DropdownMenuValues.all;

  void changeFilterValue(DropdownMenuValues value) {
      filterValue = value;
      notifyListeners();
  }

  void toggleTodoStatus(TodoItem todoObj) async {
    todoObj.toggleTodoStatus();
    await editTodoItem(todoObj);
    notifyListeners();
  }

  void createNewTodo(TodoItem todoItem) {
    DbManager.instance.insertDb(todoItem);
    todoList.add(todoItem);
    if (kDebugMode) {
      print("My todo : $todoList");
    }
    notifyListeners();
  }

  Future<void> deleteTodoItem(TodoItem todoItem) async{
    print('deleting ${todoItem.id}');
    await DbManager.instance.deleteData(todoItem);
    await readFilterValue();
    notifyListeners();
  }

  Future<void> editTodoItem(TodoItem todoItem) async {
    await DbManager.instance.updateDb(todoItem);
    await readFilterValue();
    notifyListeners();
  }

  readFilterValue() async {
    final List<Map> data = await DbManager.instance.readDb();
    print("Data read $data");
    todoList = data.map((dataMap) => TodoItem.fromJson(dataMap)).toList();
  }

}