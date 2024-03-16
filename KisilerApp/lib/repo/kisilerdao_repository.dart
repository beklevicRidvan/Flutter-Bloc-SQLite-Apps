import 'package:kisiler_uygulamasi_bootcamp/sqlite/veritabani_yardimcisi.dart';

import '../data/entity/kisiler.dart';

class KisilerDaoRepository{

  String kisilerTabloAdi = "kisiler";



  Future<List<Kisiler>> kisileriYukle() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (index)  {
      var satir = maps[index];
      return Kisiler(kisiId: satir["kisi_id"], kisiAd: satir["kisi_ad"], kisiTel:satir["kisi_tel"]);
    });
  }


  Future<void> kaydet(String kisiAd,String kisiTel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var yeniKisi = <String,dynamic>{};
    yeniKisi["kisi_ad"] = kisiAd;
    yeniKisi["kisi_tel"] = kisiTel;

    await db.insert(kisilerTabloAdi, yeniKisi);

  }

  Future<void> guncelle(int kisiId,String kisiAd,String kisiTel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var guncellenenKisi = <String,dynamic>{};
    guncellenenKisi["kisi_ad"] = kisiAd;
    guncellenenKisi["kisi_tel"] = kisiTel;

    await db.update(kisilerTabloAdi,
      guncellenenKisi,
      where: "kisi_id = ?",
      whereArgs: [kisiId]
    );

  }
  Future<void> sil(int kisiId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    db.delete(kisilerTabloAdi,
        where: "kisi_id = ?",
        whereArgs: [kisiId]
    );
  }




  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%'");
    return List.generate(maps.length, (index)  {
      var satir = maps[index];
      return Kisiler(kisiId: satir["kisi_id"], kisiAd: satir["kisi_ad"], kisiTel: satir["kisi_tel"]);

    });
  }


}