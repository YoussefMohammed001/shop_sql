class CartModel {
  List<CartItem> cartItems = [];
  double vat = 14;
  CartModel({required this.cartItems});
  double get totalPrice => cartItems.fold(
      0, (previousValue, element) => previousValue + element.totalItemPrice );

  double get vatAmount => totalPrice * vat / 100;
  double get totalAfterVat => totalPrice + (totalPrice * vat / 100);


}

class CartItem {
  int id;
  String name;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get totalItemPrice => quantity * price;
}
