import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_app/app_state.dart';
import 'package:todo_provider_app/models/todo_item_model.dart';
import 'package:todo_provider_app/widgets/todo_item_widget.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key,});


  bool visibilityCheck(TodoItem item, DropdownMenuValues filterValue) {
    switch (filterValue) {
      case DropdownMenuValues.pending:
        return !item.isCompleted;
      case DropdownMenuValues.completed:
        return item.isCompleted;
      case DropdownMenuValues.all:
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Consumer<AppStateNotifier>(
        builder: (BuildContext context, AppStateNotifier appStateNotifier, Widget? child) {
          var index = 0;
          return ListView(
            children: appStateNotifier.todoList.map((_) => buildTodoItemVisibility(context, index++, appStateNotifier)).toList(),
          );
        },
      ),
    );
  }

  Visibility buildTodoItemVisibility(BuildContext context, int index , AppStateNotifier appStateNotifier) {
    final todoObj = appStateNotifier.todoList[index];
    final filterValue = appStateNotifier.filterValue;
    return Visibility(
      visible: visibilityCheck(todoObj, filterValue),
      child: TodoItemWidget(
        index: index,
      ),
    );
  }
}
