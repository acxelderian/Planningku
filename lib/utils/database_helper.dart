import 'package:sqflite/sqflite.dart';
import 'package:dicoding/models/agenda.dart';
class DatabaseHelper{
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._internal(){
    _databaseHelper = this;
  }
  factory DatabaseHelper() => _databaseHelper??DatabaseHelper._internal();
  Future<Database> get database async{
    _database = await _initializeDb();
    return _database;
  }
  static const String _tableName='agendas';
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/agenda_db.db",
      onCreate: (db,version) async{
        await db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, nama STRING, deskripsi STRING, tanggal STRING, waktu STRING, jenis STRING)');
      },
      version: 1,
    );
    return db;
  }
  Future<void> insertAgenda(Agenda agenda) async {
    final Database db = await database;
    await db.insert(_tableName, agenda.toMap());
    print("Data inserted");
  }

  Future<List<Agenda>> getAgendas() async {
    final Database db = await database;
    List<Map<String,dynamic>> results = await db.query(_tableName);
    return results.map((res)=>Agenda.fromMap(res)).toList();
  }
  Future<Agenda> getAgendaById(int id) async {
    final Database db = await database;
    List<Map<String,dynamic>> results = await db.query(_tableName,
        where:"id=?", whereArgs: [id]);
    return results.map((res)=>Agenda.fromMap(res)).first;
  }


  Future <List<Agenda>> getAgendaByIdCanBeNull(int id) async {
    final Database db = await database;
    List<Map<String,dynamic>> results = await db.query(_tableName,
        where:"id=?", whereArgs: [id]);
    if(results.isNotEmpty) {
      return results.map((res)=>Agenda.fromMap(res)).toList();
    }
    else {
      return [];
    }
  }

  Future<void> deleteAgenda(int id) async {
    final Database db = await database;
    await db.delete(_tableName, where:'id=?', whereArgs:[id]);
  }

}