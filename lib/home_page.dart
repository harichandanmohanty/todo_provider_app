import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_app/app_state.dart';
import 'package:todo_provider_app/screens/create_todo_screen.dart';
import 'package:todo_provider_app/screens/todo_listing_screen.dart';
import 'package:todo_provider_app/widgets/filter_drop_down.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await context.read<AppStateNotifier>().readFilterValue();
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style:  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        actions: const [
          FilterDropDown(),
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()): const TodoListScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTodoScreen(),
            ),
          );
        },
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}