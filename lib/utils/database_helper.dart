import 'package:news_app/data/model/article.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _table = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_table (
           url TEXT PRIMARY KEY,
           author TEXT,
           title TEXT,
           description TEXT,
           urlToImage TEXT,
           publishedAt TEXT,
           content TEXT,
           //object
            //source O
         )     
      ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertBookmark(Articles article) async {
    final db = await database;
    await db?.insert(
      _table,
      article.toJson(),
    );
  }

  Future<List<Articles>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_table);
    return results.map((res) => Articles.fromJson(res)).toList();
  }

  Future<Map> getBookMarkByUrl(String url) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _table,
      where: 'url = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String url) async {
    final db = await database;
    await db!.delete(
      _table,
      where: 'url = ?',
      whereArgs: [url],
    );
  }
}
