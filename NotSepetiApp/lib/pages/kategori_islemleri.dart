import 'package:flutter/material.dart';
import 'package:flutter_notsepeti_uygulamasi/models/kategori.dart';
import 'package:flutter_notsepeti_uygulamasi/utils/database_helper.dart';

class Kategoriler extends StatefulWidget {
  const Kategoriler({super.key});

  @override
  State<Kategoriler> createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {

  late List<Kategori> tumKategoriler;
  late DatabaseHelper _databaseHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = [];
    _databaseHelper = DatabaseHelper();
    kategoriListesiniGuncelle();

    
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,title: Text("Kategoriler"),centerTitle: true,),
      body: ListView.builder(itemCount: tumKategoriler.length,itemBuilder: (context,index){
        var oAnkiKategori = tumKategoriler[index];
        return ListTile(
          onTap: (){
            _kategoriGuncelle(oAnkiKategori.kategoriID,oAnkiKategori);
          },
          leading: Icon(Icons.category),
          trailing: InkWell(onTap: (){
            _kategoriSilShowDialog(oAnkiKategori.kategoriID);
          },child: Icon(Icons.delete_outline)),
          title: Text(oAnkiKategori.kategoriBaslik),
        );
      }),
   
    );
  }

  void kategoriListesiniGuncelle() async{
    tumKategoriler = await _databaseHelper.kategoriListesiniGetir();

      setState(() {

      });


  }

  void _kategoriSilShowDialog(int? kategoriID) {
    showDialog(barrierDismissible: false,context: context, builder: (context){
      return AlertDialog(
        title: Text("Kategori Sil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Kategoriyi sildiğinizde bununla ilgili tüm notlar da silinecektir. Emin Misiniz? "),

            ButtonBar(
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Vazgeç")),
                TextButton(onPressed: (){
                  _databaseHelper.kategoriSil(kategoriID).then((silinenKategori) {
                    if(silinenKategori != 0){
                      kategoriListesiniGuncelle();
                      Navigator.pop(context);
                    }
                  });
                }, child: Text("Kategoriyi Sil")),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _kategoriGuncelle(int? kategoriID,Kategori oAnkiKategori) {
    kategoriGuncelleShowDialog(context,oAnkiKategori);
  }


  void kategoriGuncelleShowDialog(BuildContext context,Kategori oAnkiKategori) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        var _formKey = GlobalKey<FormState>();
        String guncellenecekKategoriAdi = "";
        return StatefulBuilder(
          builder: (context,setState){
            return SimpleDialog(
              shape: OutlineInputBorder(),
              title: Text(
                "Kategori Güncelle",
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
                        initialValue:oAnkiKategori.kategoriBaslik,
                        decoration: InputDecoration(
                          labelText: "Kategori Adı",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (yeniDeger) {
                          if (yeniDeger != null) {
                            guncellenecekKategoriAdi = yeniDeger;
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

                          _databaseHelper.kategoriGuncelle(Kategori.withID(oAnkiKategori.kategoriID, guncellenecekKategoriAdi)).then((kategoriID) {
                            if (kategoriID >0 ){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kategori Güncellendi"),duration: Duration(seconds: 1),));
                              kategoriListesiniGuncelle();
                              Navigator.pop(context);
                              setState((){});
                            }
                          });



                          /*
                          kategorileriEkle(guncellenecekKategoriAdi);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Kategori Eklendi"),
                            duration: Duration(seconds: 2),
                          ));
                          Navigator.pop(context);
                          setState((){});

                           */

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

}
