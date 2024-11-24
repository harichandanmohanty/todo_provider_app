import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_app/home_page.dart';
import 'app_state.dart';
import 'db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbManager.instance.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = 'My Tasks';
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppStateNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: title),
      ),
    );
  }
}


