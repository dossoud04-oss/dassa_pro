import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'artisan.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dassa_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE artisans (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        metier TEXT NOT NULL,
        telephone TEXT NOT NULL,
        quartier TEXT NOT NULL
      )
    ''');
  }

  // Ajouter un artisan
  Future<int> ajouterArtisan(Artisan artisan) async {
    final db = await instance.database;
    return await db.insert('artisans', artisan.toMap());
  }

  // Récupérer tous les artisans
  Future<List<Artisan>> lireArtisans() async {
    final db = await instance.database;
    final result = await db.query('artisans');
    return result.map((json) => Artisan.fromMap(json)).toList();
  }
}
