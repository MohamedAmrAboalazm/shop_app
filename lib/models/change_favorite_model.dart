class ChangeFavoriteModel
{
  bool status;
  String message;
  FavoriteDataModel data;

  ChangeFavoriteModel.fromJson(Map<String, dynamic> json)
  {
    status=json['status'];
    message=json["message"];
    data=FavoriteDataModel.fromJson(json["data"]);
  }
}
class FavoriteDataModel {
  int id;
  ProductFavoriteModel product;

  FavoriteDataModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    product=ProductFavoriteModel.fromJson(json['product']);
  }
}
class ProductFavoriteModel
{
  int id;
  dynamic price;
  dynamic old_price;
  int discount;
  String image;
  ProductFavoriteModel.fromJson(Map<String, dynamic> json)
  {
    id=json["id"];
    price=json["price"];
    old_price=json["old_price"];
    discount=json["discount"];
    image=json["image"];
  }
}