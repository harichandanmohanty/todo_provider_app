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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
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
                appStateNotifier.toggleTodoStatus(todoObj);
              },
              child: todoObj.isCompleted ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
            ),
            title: Text(
              todoObj.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: todoObj.description.isNotEmpty ? Text(
              todoObj.description,
              overflow: TextOverflow.visible,
              style: TextStyle(decoration: todoObj.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
            ): null,
            trailing: InkWell(
              onTap: () async {
                await appStateNotifier.deleteTodoItem(todoObj);
              },
              child: const Icon(Icons.delete_outline),
            ),
          );
        },
      ),
    );
  }
}
