import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_app/models/todo_item_model.dart';
import 'package:todo_provider_app/screens/todo_listing_screen.dart';
import 'package:todo_provider_app/widgets/filter_drop_down.dart';
import 'app_state.dart';
import 'screens/create_todo_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<TodoItem>(TodoItemAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = 'My Todos';
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppStateNotifier(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: FutureBuilder(
            future: context.read<AppStateNotifier>().openDbAndReadTodoList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      title: const Center(child: Text(title)),
                    ),
                    body: const Center(
                      child: Text('Something went wrong :/'),
                    ),
                  );
                } else {
                  return const MyHomePage(title: title);
                }
              } else {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    title: const Center(child: Text(title)),
                  ),
                  body: const Center(
                    child: Text('Opening My Todos...'),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(child: Text(widget.title)),
          actions: const [
            FilterDropDown(),
          ],
        ),
        body: const TodoListScreen(),
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
