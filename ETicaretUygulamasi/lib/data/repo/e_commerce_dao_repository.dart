import '../../sqlite/database_helper.dart';
import '../entity/category_model.dart';
import '../entity/favorite_model.dart';
import '../entity/order_model.dart';
import '../entity/product_model.dart';

class ECommerceDaoRepository {
  Future<List<CategoryModel>> loadCategories() async {
    var db = await DatabaseHelper.getDataBase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kategoriler");

    return List<CategoryModel>.generate(maps.length, (index) {
      var raw = maps[index];

      return CategoryModel(
          id: raw["kategori_id"], categoryName: raw["kategori_adi"]);
    });
  }

  Future<List<ProductModel>> loadProducts() async {
    final db = await DatabaseHelper.getDataBase();
    final List<Map<String, dynamic>> maps = await db.query('urunler');

    return List.generate(maps.length, (i) {
      return ProductModel(
        productId: maps[i]['urun_id'],
        productName: maps[i]['urun_adi'],
        price: maps[i]['urun_fiyati'],
        stock: maps[i]['urun_stok'],
        kategoriId: CategoryModel.fromId(maps[i]['kategori_id']),
        imageAdress: maps[i]['resim_adresi'],
      );
    });
  }

  Future<List<ProductModel>> getAllProductsByCategoryId(int categoryId) async {
    final db = await DatabaseHelper.getDataBase();
    final List<Map<String, dynamic>> maps = await db.query(
      'urunler',
      where: 'kategori_id = ?',
      whereArgs: [categoryId],
    );

    return List.generate(maps.length, (i) {
      return ProductModel(
        productId: maps[i]['urun_id'],
        productName: maps[i]['urun_adi'],
        price: maps[i]['urun_fiyati'],
        stock: maps[i]['urun_stok'],
        kategoriId: CategoryModel.fromId(maps[i]['kategori_id']),
        imageAdress: maps[i]['resim_adresi'],
      );
    });
  }

  Future<List<ProductModel>> wantedProducts(String value) async {
    var db = await DatabaseHelper.getDataBase();
    List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM urunler WHERE urun_adi like '%$value%'");
    return List.generate(maps.length, (i) {
      return ProductModel(
        productId: maps[i]['urun_id'],
        productName: maps[i]['urun_adi'],
        price: maps[i]['urun_fiyati'],
        stock: maps[i]['urun_stok'],
        kategoriId: CategoryModel.fromId(maps[i]['kategori_id']),
        imageAdress: maps[i]['resim_adresi'],
      );
    });
  }

  Future<List<FavoriteModel>> loadMyFavorites() async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.rawQuery(
      "SELECT favoriler.favori_id, favoriler.kullanici_id, favoriler.urun_id, urunler.urun_adi, urunler.resim_adresi FROM favoriler JOIN urunler ON favoriler.urun_id = urunler.urun_id",
    );

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return FavoriteModel(
        favoritesId: row["favori_id"],
        customerId: row["kullanici_id"],
        productId: row["urun_id"],
        productName: row["urun_adi"],
        imageAdress: row["resim_adresi"],
      );
    });
  }




  Future<void> addFavorite(int productId, int customerId,
      {String? productName, String? imageAdress}) async {
    var db = await DatabaseHelper.getDataBase();
    var newFavorite = <String, dynamic>{};
    newFavorite["kullanici_id"] = customerId;
    newFavorite["urun_id"] = productId;
    db.insert("favoriler", newFavorite);
  }


  Future<void> addOrder(int productId, int customerId,
      int orderPiece, String orderDate ) async {
    var db = await DatabaseHelper.getDataBase();
    var newOrder = <String, dynamic>{};
    newOrder["urun_id"] = productId;
    newOrder["musteri_id"] = customerId;
    newOrder["siparis_adeti"] = orderPiece;
    newOrder["siparis_tarihi"] = orderDate;
    db.insert("siparisler", newOrder);
  }

  Future<void> deleteFavorite(int favoriId) async {
    var db = await DatabaseHelper.getDataBase();

    db.delete("favoriler", where: "favori_id= ?", whereArgs: [favoriId]);
  }
  Future<void> deleteFavoriteByProductId(int productId) async {
    var db = await DatabaseHelper.getDataBase();

    db.delete("favoriler", where: "urun_id= ?", whereArgs: [productId]);
  }

  Future<List<OrderModel>> loadMyOrders() async {
    var db = await DatabaseHelper.getDataBase();

    List<Map<String, dynamic>> maps = await db.rawQuery(
      "SELECT siparisler.siparis_id, siparisler.urun_id, siparisler.musteri_id, siparisler.siparis_adeti, siparisler.siparis_tarihi, urunler.urun_adi, urunler.urun_fiyati,urunler.resim_adresi FROM siparisler JOIN urunler ON siparisler.urun_id = urunler.urun_id",
    );

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return OrderModel(
        orderId: row["siparis_id"],
        productId: row["urun_id"],
        customerId: row["musteri_id"],
        piece: row["siparis_adeti"],
        orderPiece : row["urun_fiyati"],
        orderDate: DateTime.parse(row["siparis_tarihi"]),
        orderName: row["urun_adi"],
        orderImageAdress: row["resim_adresi"],
      );
    });
  }



  Future<void> deleteOrder(int orderId)async{
    var db = await DatabaseHelper.getDataBase();

    await db.delete("siparisler",where: "siparis_id= ?",whereArgs: [orderId]);
  }
}
