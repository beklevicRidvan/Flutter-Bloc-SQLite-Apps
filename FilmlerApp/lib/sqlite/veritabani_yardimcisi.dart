import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {
  static const String veritabaniAdi = "filmler_app.sqlite";
  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi);
    if(await databaseExists(veritabaniYolu)){
      debugPrint("Veritabanı zaten var.Kopyalamaya gerek yok.");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);
      debugPrint("Veritabanı kopyalandı.");
    }
    return openDatabase(veritabaniYolu);
  }
}