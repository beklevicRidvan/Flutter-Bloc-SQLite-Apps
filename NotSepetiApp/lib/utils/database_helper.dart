import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_notsepeti_uygulamasi/models/kategori.dart';
import 'package:flutter_notsepeti_uygulamasi/models/notlar.dart';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';


import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  DatabaseHelper._privateConstructor();

  static final _instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper()=>_instance;


  Database? _database;

  Future<Database?> _getDataBase() async{
    if(_database == null){

      _database = await initializeDatabase();
      return _database;

    }
    else{
      return _database;
    }
  }

  Future<Database?>initializeDatabase() async{
    var lock = Lock();
    Database? _db;

    if(_db == null){
       await lock.synchronized(()async{
          var databasesPath = await getDatabasesPath();
          var path = join(databasesPath,"appDB.db");
          var file = new File(path);

          if(!await file.exists()){
            ByteData data = await rootBundle.load(join("assets","notlar.db"));
            List<int> bytes =
                data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
            await new File(path).writeAsBytes(bytes);
          }
          _db = await openDatabase(path);
       });
    }
    return _db;
  }


  Future<List<Kategori>> readTumKategoriler(int kategoriID) async{
    Database? db = await _getDataBase();
    List<Kategori> kategoriler = [];

    if(db != null){
      List<Map<String,dynamic>> kategorilerMap = await
      db.query("kategoriler",
          where: "kategoriID = ?",
          whereArgs: [kategoriID]
      );
      for(var eleman in kategorilerMap){
        Kategori k= Kategori.fromMap(eleman);
        kategoriler.add(k);
      }
    }
    return kategoriler;

  }


  Future<List<Map<String, dynamic>>> kategorileriGetir() async {
    var db = await _getDataBase();
    List<Map<String, dynamic>> sonuc = [];

    if (db != null) {
      sonuc = await db.query("kategori");
    }

    return sonuc;
  }

  Future<List<Kategori>> kategoriListesiniGetir() async{
    var kategorileriIcerenMapListesi = await kategorileriGetir();
    List<Kategori> kategoriListesi = [];

    kategoriListesi = kategorileriIcerenMapListesi
        .map((okunanMap) => Kategori.fromMap(okunanMap))
        .toList();

    return kategoriListesi;


  }




  Future<int> kategoriEkle(Kategori kategori) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.insert("kategori", kategori.toMap());

      return sonuc;
    }
    else{
      return -1;
    }
  }
  Future<int> kategoriGuncelle(Kategori kategori) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.update(
      "kategori",
       kategori.toMap(),
       where: "kategoriID = ?",
       whereArgs: [kategori.kategoriID]
      );

      return sonuc;
    }
    else{
      return 0;
    }
  }
  Future<int> kategoriSil(int? kategoriID) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.delete("kategori",where: "kategoriID= ?",whereArgs: [kategoriID]);

      return sonuc;
    }
    else{
      return 0;
    }
  }




  Future<List<Map<String,dynamic>>> notlariGetir() async{

    var db =  await _getDataBase();
    List<Map<String,dynamic>> sonuc = [];
    if(db != null){
       sonuc = await db.rawQuery('select * from "not" inner join kategori on kategori.kategoriID = "not".kategoriID;' );
      return sonuc;
    }
    return sonuc;


  }
  Future<int> notEkle(Not not) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.insert("not", not.toMap());

      return sonuc;
    }
    else{
      return -1;
    }
  }

  Future<int> notlariGuncelle(Not not) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.update(
          "not",
          not.toMap(),
          where: "notID = ?",
          whereArgs: [not.notID]
      );

      return sonuc;
    }
    else{
      return 0;
    }
  }
  Future<int> notSil(int notID) async{
    Database? db = await _getDataBase();
    if(db != null){
      var sonuc = await db.delete("not",where: "notID= ?",whereArgs: [notID]);

      return sonuc;
    }
    else{
      return 0;
    }
  }

  static String dateTimeFortmatter(String dateTime){
    DateTime myDate = DateTime.parse(dateTime);
    return "${myDate.day}/${myDate.month}/${myDate.year}";
  }













}