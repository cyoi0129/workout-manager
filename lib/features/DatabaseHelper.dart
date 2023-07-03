import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<String> getDbPath() async {
    var dbFilePath = '';

    if (Platform.isAndroid) {
      // Androidであれば「getDatabasesPath」を利用
      dbFilePath = await getDatabasesPath();
    } else if (Platform.isIOS) {
      // iOSであれば「getLibraryDirectory」を利用
      final dbDirectory = await getLibraryDirectory();
      dbFilePath = dbDirectory.path;
    } else if (Platform.isMacOS) {
      final dbDirectory = await getApplicationDocumentsDirectory();
      dbFilePath = dbDirectory.path;
    } else {
      // プラットフォームが判別できない場合はExceptionをthrow
      // 簡易的にExceptionをつかったが、自作Exceptionの方がよいと思う。
      throw Exception('Unable to determine platform.');
    }
    // 配置場所のパスを作成して返却
    final path = join(dbFilePath, 'MyWorkout.db');
    return path;
  }

  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    // String path = join(documentsDirectory.path, "MyWorkout.db");
    String path = await getDbPath();
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE workout_master (id INTEGER PRIMARY KEY, name TEXT NOT NULL, part TEXT NOT NULL, type TEXT NOT NULL)');
      await db.execute(
          'CREATE TABLE workout_task (id INTEGER PRIMARY KEY, master INTEGER NOT NULL, date TEXT NOT NULL, weight INTEGER, rep INTEGER NOT NULL, sets INTEGER NOT NULL)');
      await db.execute(
          'CREATE TABLE account_info (id INTEGER PRIMARY KEY, gender TEXT NOT NULL, age INTEGER NOT NULL, height INTEGER NOT NULL, weight INTEGER NOT NULL)');
      await db.execute(
          'CREATE TABLE weight_history (id INTEGER PRIMARY KEY, date TEXT NOT NULL, weight INTEGER NOT NULL, calorie INTEGER NOT NULL)');
      await db.execute(
          'CREATE TABLE food_master (id INTEGER PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL, protein INTEGER NOT NULL, sugar INTEGER NOT NULL, fat INTEGER NOT NULL, calorie INTEGER NOT NULL)');
      await db.execute(
          'CREATE TABLE food_task (id INTEGER PRIMARY KEY, master INTEGER NOT NULL, date TEXT NOT NULL, volume INTEGER NOT NULL)');
    }, version: 1);
  }

  // Add
  Future<int> insert(Map<String, dynamic> row, String target_table) async {
    Database? db = await instance.database;
    return await db!.insert(target_table, row);
  }

  // Get All
  Future<List<Map<String, dynamic>>> queryAllRows(String target_table) async {
    Database? db = await instance.database;
    return await db!.query(target_table);
  }

  // Get Target
  Future<List<Map<String, dynamic>>> queryTargetRows(
      String target_table, String target_column, dynamic target_value) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result = await db!.rawQuery(
        'SELECT * FROM $target_table WHERE $target_column=?',
        ['$target_value']);
    return result;
  }

  // Count
  Future<int?> queryRowCount(String target_table) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $target_table'));
  }

  //　Update
  Future<int> update(Map<String, dynamic> row, String target_table) async {
    Database? db = await instance.database;
    int id = row['id'];
    return await db!
        .update(target_table, row, where: 'id = ?', whereArgs: [id]);
  }

  //　Remove single
  Future<int> delete(int id, String target_table) async {
    Database? db = await instance.database;
    return await db!.delete(target_table, where: 'id = ?', whereArgs: [id]);
  }

  // Remove mutil
  Future<int> deleteRows(
      int id, String target_table, String target_column) async {
    Database? db = await instance.database;
    return await db!.rawDelete(
        'DELETE FROM $target_table WHERE $target_column = ?', ['$id']);
  }
}
