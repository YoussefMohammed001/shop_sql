
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/features/products/model/products_model.dart';
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

static Future deleteCategory(int id) async {
  await database!.rawQuery("DELETE FROM Categories WHERE id = $id");
}

static Future updateCategory(CategoryModel categoryModel) async {
  await database!.rawQuery("UPDATE Categories SET cat = '${categoryModel
      .category}' WHERE id = ${categoryModel.id}");
}



static Future<List<ProductsModel>> getProduct({required int catId
}) async {
  List<Map> list = await database!.rawQuery("SELECT * FROM Products WHERE cat_id = $catId");
  return list.map((e) => ProductsModel.fromJson(e)).toList();
  }


static Future addProduct(ProductsModel productsModel) async {
  await database!.rawQuery(
      "INSERT INTO Products(name, price, quantity, cat_id) VALUES('${productsModel
          .name}', ${productsModel.price}, ${productsModel
          .quantity}, ${productsModel.catId})");
}

static Future deleteProduct(int id) async {
  await database!.rawQuery("DELETE FROM Products WHERE id = $id");
}
}