import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'seminar.dart';

class DbHelperSeminar {
  static DbHelperSeminar _dbHelper;
  static Database _database;
  DbHelperSeminar._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'seminar.db';
//create, read databases
    var seminarDatabase = openDatabase(path, version: 5, onCreate: _createDb);
//mengembalikan nilai object sebagai hasil dari fungsinya
    return seminarDatabase;
  }

  FutureOr<void> _onUpgrade(Database db, int olVersion, int newVersion){
    _createDb(db, newVersion);
  }

  //buat tabel baru dengan nama seminar
  void _createDb(Database db, int version) async {
    var batchTemp = db.batch();

    await batchTemp.execute('''
      DROP TABLE EXIST seminar
    ''');
  
    await db.execute('''
      CREATE TABLE seminar (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      judul TEXT,
      waktu DATETIME,
      harga INTEGER,
      kuota INTEGER,
      lokasi TEXT,
      pembicara TEXT
      )
    ''');
    batchTemp.commit();
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('seminar', orderBy: 'waktu');
    return mapList;
  }

//create databases
  Future<int> insert(Seminar object) async {
    Database db = await this.initDb();
    int count = await db.insert('seminar', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Seminar object) async {
    Database db = await this.initDb();
    int count = await db.update('seminar', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('seminar', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Seminar>> getSeminarList() async {
    var seminarMapList = await select();
    int count = seminarMapList.length;
    List<Seminar> seminarList = [];
    for (int i = 0; i < count; i++) {
      seminarList.add(Seminar.fromMap(seminarMapList[i]));
    }
    return seminarList;
  }

  factory DbHelperSeminar() {
    if (_dbHelper == null) {
      _dbHelper = DbHelperSeminar._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
