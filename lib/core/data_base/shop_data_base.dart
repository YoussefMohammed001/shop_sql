
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:sqflite/sqflite.dart';
class ShopDatabase {
  static Database? database;

  static Future<void> init() async {
    // open the database
    await openDatabase(
      'shop.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Categories (id INTEGER PRIMARY KEY, cat TEXT)');
        await db.execute(
            'CREATE TABLE Products (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, quantity INTEGER, cat_id INTEGER, FOREIGN KEY(cat_id) REFERENCES Categories(id))');
      },
      onOpen: (db) {
        database = db;
      },
    );
  }

  static Future<List<CategoryModel>> getCategories() async {
    List<Map> list = await database!.rawQuery('SELECT * FROM Categories');
    return list.map((e) => CategoryModel.fromJson(e)).toList();
  }


static Future addCategory(CategoryModel categoryModel) async {

  await database!.rawQuery("INSERT INTO Categories(cat) VALUES('${categoryModel.category}')");
}




}