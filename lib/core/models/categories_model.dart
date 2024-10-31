class CategoryModel{
  String category = "";
  int id = 0;


  CategoryModel({required this.category, this.id = 0,});

  CategoryModel.fromJson(Map<dynamic,dynamic> map){
    category = map["cat"];
    id = map["id"];

  }
toJson() {
  return {
    "cat": category,
    "id": id,
  };
}


}