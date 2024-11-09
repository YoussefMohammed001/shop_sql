
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/features/favourite/model/invoice_model.dart';
import 'package:shop_sql/features/favourite/model/line_voice_model.dart';
import 'package:shop_sql/features/products/model/products_model.dart';
import 'package:sqflite/sqflite.dart';
class ShopDatabase {
  static Database? database;

  static Future<void> init() async {
    // open the database
    await openDatabase(
      'shop.db',
      version: 3,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Categories (id INTEGER PRIMARY KEY, cat TEXT)');
        await db.execute(
            'CREATE TABLE Products (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, quantity INTEGER, cat_id INTEGER, FOREIGN KEY(cat_id) REFERENCES Categories(id))');
        await db.execute("CREATE TABLE INVOICES (id INTEGER PRIMARY KEY, total_price INTEGER)");
        await db.execute("CREATE TABLE Line_Voices (id INTEGER PRIMARY KEY, invoice_id INTEGER, product_id INTEGER, quantity INTEGER, price INTEGER, FOREIGN KEY(invoice_id) REFERENCES INVOICES(id) ,FOREIGN KEY(product_id) REFERENCES Products(id))");



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

static Future<List<ProductsModel>> getProduct({required int catId}) async {
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


  static Future<int> addInvoice({required double totalPrice}) async {
    // Insert the new invoice and get the generated ID
    int invoiceId = await database!.rawInsert(
      "INSERT INTO INVOICES(total_price) VALUES(?)",
      [totalPrice],
    );
    return invoiceId;
  }









  static Future<int> addLineVoice({required LineVoiceModel lineVoiceModel}) async {
    // Insert the line voice and retrieve the inserted id
    var result = await database!.rawInsert(
        "INSERT INTO Line_Voices(product_id, invoice_id, quantity, price) VALUES(?, ?, ?, ?)",
        [
          lineVoiceModel.productId,
          lineVoiceModel.invoiceId,
          lineVoiceModel.quantity,
          lineVoiceModel.price,
        ]);

    // Return the inserted id (primary key)
    return result; // In SQLite, the return value of rawInsert is the id of the inserted row.
  }





static Future<List<LineVoiceModel>> getLineVoice({required int invoiceId}) async {
  List<Map> list = await database!.rawQuery("SELECT * FROM Line_Voices WHERE invoice_id = $invoiceId");
  return list.map((e) => LineVoiceModel.fromJson(e)).toList();
}


static Future<List<InvoiceModel>> getInvoices() async {
  List<Map> list = await database!.rawQuery("SELECT * FROM INVOICES");
  return list.map((e) => InvoiceModel.fromJson(e)).toList();
}

static Future<InvoiceModel> getInvoice(int id) async {
  List<Map> list = await database!.rawQuery(
      "SELECT * FROM INVOICES WHERE id = $id");
  return InvoiceModel.fromJson(list[0]);
}

}