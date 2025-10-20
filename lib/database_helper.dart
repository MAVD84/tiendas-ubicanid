import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/point_of_sale.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('points_of_sale.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE points_of_sale (
  id $idType,
  date $textType,
  business $textType,
  owner $textType,
  address $textType,
  city $textType,
  state $textType,
  zipCode $textType,
  phone $textType,
  plateQuantity $intType,
  serialNumbers $textType
)
''');
  }

  Future<PointOfSale> create(PointOfSale pointOfSale) async {
    final db = await instance.database;
    final id = await db.insert('points_of_sale', pointOfSale.toMap());
    return pointOfSale..id = id;
  }

  Future<PointOfSale> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'points_of_sale',
      columns: ['id', 'date', 'business', 'owner', 'address', 'city', 'state', 'zipCode', 'phone', 'plateQuantity', 'serialNumbers'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PointOfSale.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<PointOfSale>> readAll() async {
    final db = await instance.database;
    final result = await db.query('points_of_sale');

    return result.map((json) => PointOfSale.fromMap(json)).toList();
  }

  Future<int> update(PointOfSale pointOfSale) async {
    final db = await instance.database;
    return db.update(
      'points_of_sale',
      pointOfSale.toMap(),
      where: 'id = ?',
      whereArgs: [pointOfSale.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'points_of_sale',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
