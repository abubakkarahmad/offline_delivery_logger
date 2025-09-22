import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalDb {
  final Database db;

  LocalDb._(this.db);

  static Future<LocalDb> open({bool inMemory = false}) async {
    final Database database;
    if (inMemory) {
      database = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: _onCreate,
      );
    } else {
      final dir = await getApplicationDocumentsDirectory();
      final path = p.join(dir.path, 'offline_delivery_logger.db');
      database = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
    return LocalDb._(database);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE deliveries (
        id TEXT PRIMARY KEY,
        customer TEXT NOT NULL,
        address TEXT NOT NULL,
        notes TEXT,
        status TEXT NOT NULL
      );
    ''');
    await db.execute('''
      CREATE TABLE delivery_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        delivery_id TEXT NOT NULL,
        status TEXT NOT NULL,
        at TEXT NOT NULL,
        lat REAL NOT NULL,
        lng REAL NOT NULL,
        FOREIGN KEY(delivery_id) REFERENCES deliveries(id) ON DELETE CASCADE
      );
    ''');
    await db.execute('''
      CREATE TABLE outbox (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        delivery_id TEXT NOT NULL,
        payload_json TEXT NOT NULL,
        attempts INTEGER NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');
    await db.execute(
      'CREATE INDEX idx_delivery_events_delivery_id ON delivery_events(delivery_id);',
    );
    await db.execute(
      'CREATE INDEX idx_outbox_created_at ON outbox(created_at);',
    );
  }

  Future<void> close() async => db.close();
}
