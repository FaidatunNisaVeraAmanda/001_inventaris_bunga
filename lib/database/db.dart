import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:inventaris_bunga/modul/inventaris.dart';

class Db {
  static Db _db;
  static Database _database;

  Db._createObject();

  factory Db() {
    if (_db == null) {
      _db = Db._createObject();
    }
    return _db;
  }
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'inventaris.db';
    //membuat dan melihat database
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE inventaris (
        kode_inventaris INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        latin TEXT,
        kelas TEXT,
        keluarga TEXT,
        spesies TEXT)''',
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('inventaris', orderBy: 'kode_inventaris');
    return mapList;
  }

// fungsi tambah data
  Future<int> insert(Bunga bunga) async {
    Database db = await this.database;
    int count = await db.insert('inventaris', bunga.toMap());
    return count;
  }

  Future<int> dummyData() async {
    Database db = await this.database;
    Map<String, dynamic> inventarisSatu = Map<String, dynamic>();
    inventarisSatu['kode_inventaris'] = "1";
    inventarisSatu['nama'] = "Mawar";
    inventarisSatu['latin'] = "Rosa hybrida";
    inventarisSatu['kelas'] = "Dicotyledona ordo";
    inventarisSatu['keluarga'] = "Risaceae";
    inventarisSatu['spesies'] = "Rosa multiflora L";
    Map<String, dynamic> inventarisDua = Map<String, dynamic>();
    inventarisDua['kode_inventaris'] = "2";
    inventarisDua['nama'] = "Melati";
    inventarisDua['latin'] = "Jasminum sambac";
    inventarisDua['kelas'] = "Magnoliopsida";
    inventarisDua['keluarga'] = "Oleaceae";
    inventarisDua['spesies'] = "J. sambac";
    int count = await db.insert('inventaris', inventarisSatu);
    int count2 = await db.insert('inventaris', inventarisDua);
    if (count == 1 && count2 == 1) {
      return 1;
    }
    return 0;
  }

// fungsi update data
  Future<int> update(Bunga bunga) async {
    Database db = await this.database;
    int count = await db.update('inventaris', bunga.toMap(),
        where: 'kode_inventaris=?', whereArgs: [bunga.kodeInventaris]);
    return count;
  }

// fungsi hapus data
  Future<int> delete(int kodeinventaris) async {
    Database db = await this.database;
    int count =
        await db.delete('inventaris', where: 'kode_inventaris=?', whereArgs: [kodeinventaris]);
    return count;
  }

  //fungsi pemanggilan data
  Future<List<Bunga>> getBungaList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Bunga> bungaList = List<Bunga>();
    for (int i = 0; i < count; i++) {
      bungaList.add(Bunga.fromJson(contactMapList[i]));
    }
    return bungaList;
  }
}