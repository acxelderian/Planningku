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
        await db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, task TEXT, owner TEXT, dateCreated TEXT)');
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
}