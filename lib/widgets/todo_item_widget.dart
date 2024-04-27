import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../models/todo_item_model.dart';
import '../screens/todo_item_details_screen.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color.fromARGB(30, 50, 0, 200), borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Consumer<AppStateNotifier>(
        builder: (BuildContext context, appStateNotifier, Widget? child) {
          TodoItem todoObj = appStateNotifier.todoList[index];
          return  ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodoItemDetailScreen(
                  todoObj: todoObj,
                  index: index,
                ),
              ));
            },
            leading: InkWell(
              onTap: () {
                appStateNotifier.toggleTodoStatus(todoObj, index);
              },
              child: todoObj.isCompleted ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
            ),
            title: Text(
              todoObj.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
            ),
            subtitle: Text(
              todoObj.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
            ),
            trailing: InkWell(
              onTap: () {
                appStateNotifier.deleteTodoItem(todoObj, index);
              },
              child: const Icon(Icons.delete_outline),
            ),
          );
        },
      ),
    );
  }
}
