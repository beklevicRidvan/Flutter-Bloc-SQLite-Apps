import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bootcamp/ui/cubit/detay_sayfa_cubit.dart';

import '../../data/entity/kisiler.dart';

class DetaySayfa extends StatefulWidget {
  Kisiler kisi;
  DetaySayfa({super.key, required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();



  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisiAd;
    tfKisiTel.text = kisi.kisiTel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detay Sayfa"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(controller: tfKisiAdi,decoration: const InputDecoration(hintText: "Kişi Ad"),),
              TextField(controller: tfKisiTel,decoration: const InputDecoration(hintText: "Kişi Tel"),),
              ElevatedButton(onPressed: (){
                context.read<DetaySayfaCubit>().guncelle(widget.kisi.kisiId, tfKisiAdi.text, tfKisiTel.text);
              }, child: const Text("GÜNCELLE"))
            ],
          ),
        ),
      ),
    );
  }
}
