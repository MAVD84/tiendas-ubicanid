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

    return await openDatabase(path, version: 5, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE points_of_sale(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      business TEXT NOT NULL,
      owner TEXT NOT NULL,
      address TEXT NOT NULL,
      city TEXT NOT NULL,
      state TEXT NOT NULL,
      zipCode TEXT NOT NULL,
      phone TEXT NOT NULL,
      plateQuantity INTEGER NOT NULL,
      serialNumbers TEXT NOT NULL,
      price REAL NOT NULL,
      notes TEXT,
      visits TEXT
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var tableInfo = await db.rawQuery('PRAGMA table_info(points_of_sale)');
    List<String> columnNames = tableInfo.map((column) => column['name'] as String).toList();

    if (oldVersion < 3 && !columnNames.contains('notes')) {
        await db.execute("ALTER TABLE points_of_sale ADD COLUMN notes TEXT");
    }
    if (oldVersion < 4 && !columnNames.contains('visits')) {
        await db.execute("ALTER TABLE points_of_sale ADD COLUMN visits TEXT");
    }
     if (oldVersion < 5 && !columnNames.contains('notes')) {
        await db.execute("ALTER TABLE points_of_sale ADD COLUMN notes TEXT");
    }
  }


  Future<PointOfSale> create(PointOfSale pointOfSale) async {
    final db = await instance.database;
    final id = await db.insert('points_of_sale', pointOfSale.toMap());
    return PointOfSale(
      id: id,
      date: pointOfSale.date,
      business: pointOfSale.business,
      owner: pointOfSale.owner,
      address: pointOfSale.address,
      city: pointOfSale.city,
      state: pointOfSale.state,
      zipCode: pointOfSale.zipCode,
      phone: pointOfSale.phone,
      plateQuantity: pointOfSale.plateQuantity,
      serialNumbers: pointOfSale.serialNumbers,
      price: pointOfSale.price,
      notes: pointOfSale.notes,
      visits: pointOfSale.visits,
    );
  }

  Future<PointOfSale> readPointOfSale(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'points_of_sale',
      columns: ['id', 'date', 'business', 'owner', 'address', 'city', 'state', 'zipCode', 'phone', 'plateQuantity', 'serialNumbers', 'price', 'notes', 'visits'],
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
    const orderBy = 'date DESC';
    final result = await db.query('points_of_sale', orderBy: orderBy);

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
