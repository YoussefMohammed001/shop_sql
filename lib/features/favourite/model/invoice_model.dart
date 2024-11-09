class InvoiceModel{
  int id = 0;
  int totalPrice = 0;
  InvoiceModel({required this.id, required this.totalPrice});

  factory InvoiceModel.fromJson(Map<dynamic, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      totalPrice: json['total_price'],
    );
  }

}