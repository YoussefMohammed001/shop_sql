class ProductsModel {
int id = 0;
String name = "";
int price = 0;
int quantity = 0;
int catId = 0;

ProductsModel({ this.id = 0, required this.name, required this.price, required this.quantity, required this.catId});

factory ProductsModel.fromJson(Map<dynamic, dynamic> json) {
  return ProductsModel(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    quantity: json['quantity'],
    catId: json['cat_id'],
  );
}

}