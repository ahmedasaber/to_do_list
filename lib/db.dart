import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDatabase {

  static Database? _db;

  Future<Database?> get db async {
    if(_db == null){
      _db = await initDatabase();
      return _db;
    }
    return _db;
  }

  Future<Database> initDatabase() async{
    String systemPath = await getDatabasesPath();
    String fullDbPath = join(systemPath, 'note_database.dp');
    Database myDb = await openDatabase(fullDbPath, version: 1, onCreate: _onCreate);
    return myDb;
  }
  _onCreate(Database db, int version) async{
    await db.execute("""
      create table notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT, -- Store JSON string
        created_at created_at TEXT NOT NULL
      );
    """);
  }

  Future<List<Map>>getData(String sql) async{
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }
  Future<int> insetData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }
  Future<int> updateData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }
  Future<int> deleteData(String sql) async{
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}