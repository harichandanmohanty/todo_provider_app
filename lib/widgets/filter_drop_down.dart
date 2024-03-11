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
        return DropdownButton(
          underline: Container(
            height: 2,
            color: Colors.purpleAccent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          value: appStateNotifier.filterValue,
          icon: const Icon(Icons.filter_alt_outlined),
          items: DropdownMenuValues.values.map((DropdownMenuValues item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.name),
            );
          }).toList(),
          onChanged: (DropdownMenuValues? value) {
            appStateNotifier.changeFilterValue(value!);
          },
        );
      },
    );
  }
}