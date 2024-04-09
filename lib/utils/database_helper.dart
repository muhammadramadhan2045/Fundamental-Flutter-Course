import 'package:local_db/model/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper

  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'notes';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'note_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(_tableName, note.toMap());
    print('Note inserted');
  }

  Future<List<Note>> getNotes() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    return results.map((e) => Note.fromMap(e)).toList();
  }

  Future<Note> getNoteById(int id) async {
    final db = await _database;
    final List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((e) => Note.fromMap(e)).first;
  }

  //update
  Future<void> updateNote(Note note) async {
    final db = await _database;
    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //delete
  Future<void> deleteNote(int id) async {
    final db = await _database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
