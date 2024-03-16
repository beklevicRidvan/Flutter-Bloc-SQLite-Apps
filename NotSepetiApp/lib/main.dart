import 'package:flutter/material.dart';
import 'package:flutter_notsepeti_uygulamasi/models/kategori.dart';
import 'package:flutter_notsepeti_uygulamasi/models/notlar.dart';
import 'package:flutter_notsepeti_uygulamasi/pages/kategori_islemleri.dart';
import 'package:flutter_notsepeti_uygulamasi/pages/not_detay.dart';
import 'package:flutter_notsepeti_uygulamasi/utils/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: NotListesi(),
    );
  }
}

class NotListesi extends StatelessWidget {
  NotListesi({super.key});
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Not Sepeti",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context){
            return [
              PopupMenuItem(child: ListTile(leading: Icon(Icons.category),title: Text("Kategoriler"),onTap: (){
                Navigator.pop(context);
                kategorilerSayfasinaGit(context);
              },)),
            ];
          })
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "KategoriEkle",
              shape: StadiumBorder(),
              onPressed: () {
                kategoriEkleShowDialog(context);
              },
              child: Icon(Icons.add),
              mini: true),
          SizedBox(height: 5),
          FloatingActionButton(
            heroTag: "NotEkle",
            shape: StadiumBorder(),
            onPressed: () {
              _detaySayfasinaGit(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Notlar(),
    );
  }

  void kategoriEkleShowDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var _formKey = GlobalKey<FormState>();
        String yeniKategoriAdi = "";
        return StatefulBuilder(
          builder: (context,setState){
            return SimpleDialog(
              shape: OutlineInputBorder(),
              title: Text(
                "Kategori Ekle",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Kategori Adı",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (yeniDeger) {
                          if (yeniDeger != null) {
                            yeniKategoriAdi = yeniDeger;
                          }
                        },
                        validator: (girilenKategoriAdi) {
                          if (girilenKategoriAdi != null) {
                            if (girilenKategoriAdi.length < 3) {
                              return "En az 3 karakter giriniz";
                            }
                          }
                        },
                      ),
                    )),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Vazgeç",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          kategorileriEkle(yeniKategoriAdi);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Kategori Eklendi"),
                            duration: Duration(seconds: 2),
                          ));
                          setState((){});
                          Navigator.pop(context);


                        }
                      },
                      child: Text(
                        "Kaydet",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder()),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void kategorileriEkle(String yeniKategoriAdi) async {
    int printKategori =
        await _databaseHelper.kategoriEkle(Kategori(yeniKategoriAdi));

    print(printKategori);
  }

  void _detaySayfasinaGit(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotDetay(baslik: "Yeni Not")));
  }

  void kategorilerSayfasinaGit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Kategoriler()));
  }
}

class Notlar extends StatefulWidget {
  const Notlar({super.key});

  @override
  State<Notlar> createState() => _NotlarState();
}

class _NotlarState extends State<Notlar> {
  late List<Not> tumNotlar;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumNotlar = [];
    _databaseHelper = DatabaseHelper();
    notlariGetir();
  }

  Future<void> notlariGetir() async {
    try {
      List<Map<String, dynamic>> notlariIcerenMapListesi =
          await _databaseHelper.notlariGetir();

      setState(() {
        tumNotlar = notlariIcerenMapListesi
            .map((okunanMap) => Not.fromMap(okunanMap))
            .toList();
      });
    } catch (e) {
      print("Notları getirme hatası: $e");
    }
  }

  void _detaylarSayfasinaGit(BuildContext context, Not oAnkiNot) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotDetay(
                  baslik: "Yeni Not",
                  duzenlenecekOlanNot: oAnkiNot,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: tumNotlar.length > 0
            ? FutureBuilder(
                future: notlariGetir(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: tumNotlar.length,
                      itemBuilder: (BuildContext context, int index) {
                        var oAnkiNot = tumNotlar[index];
                        return Container(
                            child: ExpansionTile(
                          leading: _oncelikIconuAta(oAnkiNot.notOncelik),
                          title: Text(
                            oAnkiNot.notBaslik,
                            style: TextStyle(color: Colors.black),
                          ),
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Kategori",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          oAnkiNot.kategoriBaslik ?? "",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          "Oluşturulma Tarihi",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          DatabaseHelper.dateTimeFortmatter(
                                              oAnkiNot.notTarih),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      "İcerik:\n ${oAnkiNot.notIcerik}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder()),
                                          onPressed: () =>
                                              notSil(oAnkiNot.notID),
                                          child: Text(
                                            "SİL",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder()),
                                          onPressed: () {
                                            _detaylarSayfasinaGit(
                                                context, oAnkiNot);
                                          },
                                          child: Text(
                                            "GÜNCELLE",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                      });
                },
              )
            : const Center(
                child:Text(
                "Yükleniyor.."
              )));
  }

  _oncelikIconuAta(int notOncelik) {
    switch (notOncelik) {
      case 0:
        return CircleAvatar(
          child: Text("AZ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.redAccent.shade100,
        );

      case 1:
        return CircleAvatar(
          child: Text("ORTA",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red.shade400,
        );

      case 2:
        return CircleAvatar(
          child: Text(
            "ACİL",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade900,
        );
    }
  }

  notSil(int? notID) async {
    if (notID != null) {
      int silinenID = await _databaseHelper.notSil(notID);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Not başarıyla silindi")));
      print(silinenID);
      setState(() {});
    }
  }
}
