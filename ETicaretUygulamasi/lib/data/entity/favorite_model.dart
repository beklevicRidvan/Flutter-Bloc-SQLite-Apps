class FavoriteModel{
  int favoritesId ;
  int customerId;
  int productId;
  String? productName;
  String? imageAdress;
  bool? isFavorited;

  FavoriteModel({required this.favoritesId,required this.customerId,required this.productId,this.productName,this.imageAdress});
}