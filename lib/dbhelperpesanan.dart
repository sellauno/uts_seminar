import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'pesanan.dart';

class DbHelperPesanan {
  static DbHelperPesanan _dbHelper;
  static Database _database;
  DbHelperPesanan._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'pesanan.db';
//create, read databases
    var pesananDatabase = openDatabase(path, version: 5, onCreate: _createDb);
//mengembalikan nilai object sebagai hasil dari fungsinya
    return pesananDatabase;
  }

  FutureOr<void> _onUpgrade(Database db, int olVersion, int newVersion){
    _createDb(db, newVersion);
  }

  //buat tabel baru dengan nama pesanan
  void _createDb(Database db, int version) async {
    var batchTemp = db.batch();

    await batchTemp.execute('''
      DROP TABLE EXIST pesanan
    ''');
  
    await db.execute('''
      CREATE TABLE pesanan (
      idPesanan INTEGER PRIMARY KEY AUTOINCREMENT,
      nama TEXT,
      email TEXT,
      noTelp TEXT,
      idSeminar INTEGER
      )
    ''');
    batchTemp.commit();
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('pesanan', orderBy: 'idPesanan');
    return mapList;
  }

//create databases
  Future<int> insert(Pesanan object) async {
    Database db = await this.initDb();
    int count = await db.insert('pesanan', object.toMap());
    return count;
  }

//update databases
  Future<int> update(Pesanan object) async {
    Database db = await this.initDb();
    int count = await db
        .update('pesanan', object.toMap(), where: 'idPesanan=?', whereArgs: [object.idPesanan]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('pesanan', where: 'idPesanan=?', whereArgs: [id]);
    return count;
  }

  Future<List<Pesanan>> getPesananList() async {
    var pesananMapList = await select();
    int count = pesananMapList.length;
    List<Pesanan> pesananList = [];
    for (int i = 0; i < count; i++) {
      pesananList.add(Pesanan.fromMap(pesananMapList[i]));
    }
    return pesananList;
  }

  factory DbHelperPesanan() {
    if (_dbHelper == null) {
      _dbHelper = DbHelperPesanan._createObject();
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
