import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_provider_app/models/todo_item_model.dart';

class DbManager {
  DbManager._createInstance();

  static final DbManager _instance = DbManager._createInstance();

  static DbManager get instance {
    return _instance;
  }

  static late final Database db;

  initDb() async{
    db = await openDatabase(
      join(await getDatabasesPath(), 'todolist_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT, isCompleted INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  insertDb(TodoItem todoItem) async{
    await db.insert(
      'todo',
      todoItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateDb(TodoItem todoItem)  async {
    await db.update('todo', todoItem.toJson(), where: 'id = ${todoItem.id}');
  }

  deleteData(TodoItem todoItem) async {
    await db.delete('todo', where: 'id = ${todoItem.id}');
  }

  Future<List<Map>> readDb() async {
    return await db.query('todo', columns: ['id', 'title', 'description', 'isCompleted']);
  }
}