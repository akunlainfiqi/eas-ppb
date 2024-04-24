import 'package:ets_ppb/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  static final MovieDatabase instance = MovieDatabase._init();

  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
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

    await db.execute('''
    CREATE TABLE movie (
      ${MovieFields.id} $idType,
      ${MovieFields.title} $textType,
      ${MovieFields.imageUrl} $textType,
      ${MovieFields.description} $textType,
      ${MovieFields.dateCreated} $textType,
      ${MovieFields.dateUpdated} $textType
    )
    ''');
  }

  Future<Movie> create(Movie movie) async {
    final db = await instance.database;
    final id = await db.insert('movie', movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> getOne(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'movie',
      columns: MovieFields.values,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Movie>> getAll() async {
    final db = await instance.database;
    final result = await db.query('movie');

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> update(Movie movie) async {
    final db = await instance.database;

    return db.update(
      'movie',
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'movie',
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
