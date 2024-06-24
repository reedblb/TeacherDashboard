import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'class_registry.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE class_registry (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertClass(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('class_registry', row);
  }

  Future<List<Map<String, dynamic>>> queryAllClasses() async {
    Database db = await database;
    return await db.query('class_registry');
  }

  Future<int> updateClass(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('class_registry', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteClass(int id) async {
    Database db = await database;
    return await db.delete('class_registry', where: 'id = ?', whereArgs: [id]);
  }
}
