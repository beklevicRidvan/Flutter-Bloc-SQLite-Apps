class OrderModel{
  int orderId;
  int productId;
  int customerId;
  int piece;
  dynamic orderPiece;
  DateTime orderDate;
  String? orderName;
  String? orderImageAdress;


  OrderModel({required this.orderId,required this.productId,required this.customerId,required this.piece,required this.orderPiece,required this.orderDate,this.orderName,this.orderImageAdress});

}