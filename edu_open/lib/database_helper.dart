import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        senha TEXT,
        email TEXT,
        proposito TEXT,
        nomeUniversidade TEXT,
        curso TEXT,
        tipoInstituicao TEXT,
        titularidade TEXT,
        nomeEmpresa TEXT,
        ocupacaoEmpresa TEXT,
        urlEmpresa TEXT,
        nomeCompleto TEXT,
        dataNascimento TEXT,
        cep TEXT,
        endereco TEXT,
        numero TEXT,
        bairro TEXT,
        cidade TEXT,
        uf TEXT
      )
    ''');
  }

  Future<int> insertUsuario(Map<String, dynamic> usuario) async {
    Database? db = await database;
    return await db!.insert('usuarios', usuario);
  }

  Future<bool> authenticateUser(String username, String password) async {
    Database db = await _instance.database;

    List<Map<String, dynamic>> result = await db.query(
      'usuarios',
      where: 'nome = ? AND senha = ?',
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  // Outros métodos do DatabaseHelper...
}
