class LineVoiceModel {
  int id = 0;
  int productId = 0;
  int quantity = 0;
  int price = 0;

  LineVoiceModel({
     this.id = 0,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  LineVoiceModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
  }
}