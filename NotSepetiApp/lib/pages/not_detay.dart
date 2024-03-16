import 'package:flutter/material.dart';
import 'package:flutter_notsepeti_uygulamasi/models/kategori.dart';
import 'package:flutter_notsepeti_uygulamasi/models/notlar.dart';
import 'package:flutter_notsepeti_uygulamasi/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String baslik;
  Not? duzenlenecekOlanNot;
  NotDetay({required this.baslik, this.duzenlenecekOlanNot, super.key});

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  late List<Kategori> tumKategoriler;
  late DatabaseHelper _databaseHelper;
  final _formKey = GlobalKey<FormState>();
  int kategoriID = 1;
  int secilenOncelik = 0;

  static final _oncelik = ["Düşük", "Orta", "Yüksek"];
  String notBasligi = "";
  String? notIcerigi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = [];
    _databaseHelper = DatabaseHelper();
    _kategoriListesiniGetir();
  }

  Future<void> _kategoriListesiniGetir() async {
    try {
      List<Map<String, dynamic>> kategorileriIcerenMapListesi =
          await _databaseHelper.kategorileriGetir();

      setState(() {
        tumKategoriler = kategorileriIcerenMapListesi
            .map((okunanMap) => Kategori.fromMap(okunanMap))
            .toList();
      });
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.baslik,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: tumKategoriler.isEmpty
          ? const Center(child: Text("Not Listesi Boş"))
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Kategori :",
                        style: TextStyle(fontSize: 24),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 24),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                              value: widget.duzenlenecekOlanNot == null
                                  ? kategoriID
                                  : widget.duzenlenecekOlanNot!.kategoriID,
                              items: kategoriItemleriOlustur(),
                              onChanged: (secilenKategoriID) {
                                setState(() {
                                  kategoriID = secilenKategoriID!;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.duzenlenecekOlanNot != null
                          ? widget.duzenlenecekOlanNot!.notBaslik
                          : "",
                      validator: (text) {
                        if (text != null) {
                          if (text.length < 3) {
                            return "En az 3 karakter olmalı";
                          }
                        }
                        return null;
                      },
                      onSaved: (text) {
                        if (text != null) {
                          notBasligi = text;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Not başlığı giriniz",
                        labelText: "Başlık",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: widget.duzenlenecekOlanNot != null
                          ? widget.duzenlenecekOlanNot!.notIcerik
                          : "",
                      onSaved: (text) {
                        notIcerigi = text;
                      },
                      maxLines: 4,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Not içeriğini giriniz",
                        labelText: "İçerik",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Öncelik :",
                        style: TextStyle(fontSize: 24),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 24),
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.redAccent, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                              value: widget.duzenlenecekOlanNot != null
                                  ? widget.duzenlenecekOlanNot!.notOncelik
                                  : secilenOncelik,
                              items: _oncelik.map((oncelik) {
                                return DropdownMenuItem<int>(
                                    value: _oncelik.indexOf(oncelik),
                                    child: Text(oncelik));
                              }).toList(),
                              onChanged: (secilenOncelikID) {
                                setState(() {
                                  secilenOncelik = secilenOncelikID!;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: const RoundedRectangleBorder()),
                        child: const Text(
                          "Vazgeç",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {

                           if (_formKey.currentState!.validate()) {
                             _formKey.currentState!.save();
                             if(widget.duzenlenecekOlanNot == null) {
                               notEkle();
                             }
                             else{
                               notGuncelle();
                             }

                           }

                           },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: const RoundedRectangleBorder()),

                        child: const Text(
                          "Kaydet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemleriOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
            value: kategori.kategoriID,
            child: Text(
              kategori.kategoriBaslik,
              style: const TextStyle(fontSize: 22),
            )))
        .toList();
  }

  void notEkle() async {
    int notID = await _databaseHelper.notEkle(Not(kategoriID, notBasligi,
        notIcerigi, DateTime.now().toString(), secilenOncelik));
    if (notID != 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Not başarıyla kaydedildi")));
      Navigator.pop(context);
    }
  }

  void notGuncelle() async{
    int etkilenenID = await _databaseHelper.notlariGuncelle(Not.withID(widget.duzenlenecekOlanNot!.notID, kategoriID, notBasligi, notIcerigi, DateTime.now().toString(), secilenOncelik));
   if(etkilenenID>0){
     Navigator.pop(context);
   }
  }
}
