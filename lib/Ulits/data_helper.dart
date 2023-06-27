import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dbhelper {
  Database? database;

  Future<Database?> checkdb() async {
    if (database != null) {
      return database;
    } else {
      return await initdb();
    }
  }

  Future<Database?> initdb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "rnw.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE incomeexpense (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,amount TEXT,notes TEXT,status TEXT,date TEXT,time TEXT,paytype TEXT  )";
        db.execute(query);
      },
    );
  }

  Future<void> insertdata(
      {required category,
        required amount,
        required status,
        required notes,
        required date,
        required time,
        required paytype}) async {
    database = await checkdb();
    database!.insert("incomeexpense", {
      "category": category,
      "amount": amount,
      "status": status,
      "notes": notes,
      "paytype": paytype,
      "date": date,
      "time": time,
    });
  }

  Future<List<Map>> readdata() async {
    database = await checkdb();
    String query = "SELECT * FROM incomeexpense";
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<void> deletedata({required id}) async {
    database = await checkdb();
    database!.delete('incomeexpense', where: "id=?", whereArgs: [id]);
  }

  Future<void> updatedata(
      {required id,
        required category,
        required amount,
        required status,
        required notes,
        required date,
        required time,
        required paytype}) async {
    database = await checkdb();
    database!.update(
        'incomeexpense',
        {
          "category": category,
          "amount": amount,
          "status": status,
          "notes": notes,
          "paytype": paytype,
          "date": date,
          "time": time,
        },
        where: 'id=?',
        whereArgs: [id]);
  }


  Future<List<Map>> incomeexpensefilter({required s1})
  async {
    database = await checkdb();
    String sql = 'SELECT * FROM incomeexpense WHERE status = $s1';
    List<Map> list = await database!.rawQuery(sql);
    return list;
  }

  Future<List<Map>> decendingfilter()
  async {
    database = await checkdb();
    String sql = 'SELECT * FROM incomeexpense ORDER BY id DESC';
    List<Map> list = await database!.rawQuery(sql);
    return list;
  }
  Future<List<Map>> assending()
  async {
    database=await checkdb();
    String sql ='SELECT * FROM incomeexpense ORDER BY id';
    List<Map> list=await database!.rawQuery(sql);
    return list;
  }
}