import 'category_model.dart';

class ProductModel {
  int productId;
  String productName;
  dynamic price;
  int stock;
  CategoryModel kategoriId;
  String imageAdress;

  ProductModel(
      {required this.productId,
      required this.productName,
      required this.price,
      required this.stock,
      required this.kategoriId,
      required this.imageAdress});
}
