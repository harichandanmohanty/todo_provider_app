import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_app/app_state.dart';
import '../models/todo_item_model.dart';

class FilterDropDown extends StatelessWidget {
  const FilterDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (BuildContext context, appStateNotifier, Widget? child) {
        return MenuAnchor(
            menuChildren: DropdownMenuValues.values.map((DropdownMenuValues item) {
              return MenuItemButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateColor.resolveWith((states) {
                  return appStateNotifier.filterValue == item ? Colors.grey: Colors.white;
                },)),
                child: Text(item.name),
                onPressed: () {
                  appStateNotifier.changeFilterValue(item);
                },
              );
            }).toList(),
          builder: (context, menuController, _) {
              return IconButton(onPressed: () {
                if(menuController.isOpen) {
                  menuController.close();
                } else {
                  menuController.open();
                }
              }, icon: const Icon(Icons.filter_list_sharp));
        },
        );
      },
    );
  }
}