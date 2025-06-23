import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/fishing_entry.dart';

class LocalDbService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'fishing.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE fishing_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, fishermanName TEXT, boatName TEXT, date TEXT, categories TEXT, quantity INTEGER, inseminated INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertEntry(FishingEntry entry) async {
    final db = await database;
    await db.insert('fishing_entries', entry.toMap());
  }

  static Future<List<FishingEntry>> getEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('fishing_entries');
    return List.generate(maps.length, (i) => FishingEntry.fromMap(maps[i]));
  }

  static Future<void> deleteAll() async {
    final db = await database;
    await db.delete('fishing_entries');
  }
  static Future<void> deleteEntry(int id) async {
  final db = await database;
  await db.delete('fishing_entries', where: 'id = ?', whereArgs: [id]);
}
}