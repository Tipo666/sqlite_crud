import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'product.dart';

class DBHelper {

  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE = 'product';
  static const String DB_NAME = 'product.db';

  //getter
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  ///Método initDb()
  ///
  ///Con este método iniciamos la base de datos.
  ///
  /// Obteniendo la ruta en la cual se encuentra dentro del dispositivo.
  ///
  ///
  ///
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  ///Método _onCreate(Database, int)
  ///
  ///Con este método creamos la base de datos.
  ///
  ///
  ///
  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT)");
  }

  ///Método save(Product)
  ///
  ///Con este meétodo grabamos en la base de datos, insertando dentro de la tabla
  ///
  ///
  ///
  Future<Product> save(Product product) async {
    var dbClient = await db;
    product.id = await dbClient.insert(TABLE, product.toMap());
    return product;
  }

  ///Método getProducts()
  ///
  ///
  ///Con este método leemos la base de datos y obtenemos los datos contenidos en ella.
  ///
  ///
  Future<List<Product>> getProducts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    List<Product> products = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        products.add(Product.fromMap(maps[i]));
      }
    }
    return products;
  }

  ///Método delete(int)
  ///
  ///Con este método borramos un elemento de la base de datos.
  ///
  ///
  ///
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  ///Método update(Product)
  ///
  ///Con este método actualizamos la base de datos.
  ///
  ///
  ///
  Future<int> update(Product product) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, product.toMap(),
        where: '$ID = ?', whereArgs: [product.id]);
  }

  ///Método close()
  ///
  ///Con este método cerramos la base de datos.
  ///
  ///
  ///
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}

