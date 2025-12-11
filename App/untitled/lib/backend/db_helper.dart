import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'report_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('reports.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      age TEXT NOT NULL,
      healthStatus TEXT NOT NULL,
      location TEXT NOT NULL,
      time TEXT NOT NULL,
      relationship TEXT NOT NULL,
      reporterID TEXT NOT NULL,
      description TEXT NOT NULL,
      imagePath TEXT
    )
    ''');
  }

  Future<int> createReport(ReportModel report) async {
    final db = await instance.database;
    return await db.insert('reports', report.toMap());
  }

  Future<List<ReportModel>> getAllReports() async {
    final db = await instance.database;

    final result = await db.query('reports', orderBy: 'id DESC');

    return result.map((json) => ReportModel.fromMap(json)).toList();
  }

}