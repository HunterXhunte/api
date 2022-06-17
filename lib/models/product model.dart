class ProductModel{
  String ?title;
  num ?price;
  String ?description;
  String ?category;
  String ?image;
  int ?count;
  num ?rate;
  ProductModel({
    this.title,
    this.image,
    this.price,
    this.category,
    this.description,
    this.rate,
    this.count
});
  static ProductModel fromJson(Map<String,dynamic> map){
    ProductModel p = ProductModel(
      image: map["image"],
      price: map["price"],
      title: map["title"],
      description: map["description"],
      category: map["category"],
      rate: map["rating"]["rate"],
      count: map["rating"]["count"]
    );
    return p;
  }

}
// class Rating{
//   num ?rate;
//   int ?count;
//   Rating({this.count,this.rate});
//   static Rating fromJson(Map<String,dynamic> map){
//     return Rating();
//   }
// }