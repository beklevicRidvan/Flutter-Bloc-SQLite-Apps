import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bootcamp/ui/cubit/anasayfa_cubit.dart';

import '../../data/entity/kisiler.dart';
import 'detay_sayfa.dart';
import 'kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;









  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnaSayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<AnaSayfaCubit>().ara(aramaSonucu);
          },
        ) :
        const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
            });
            context.read<AnaSayfaCubit>().kisileriYukle();

          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<AnaSayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,//3
              itemBuilder: (context,indeks){//0,1,2
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetaySayfa(kisi: kisi)))
                        .then((value) {
                      context.read<AnaSayfaCubit>().kisileriYukle();

                    });
                  },
                  child: Card(
                    child: SizedBox(height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(kisi.kisiAd,style: const TextStyle(fontSize: 20),),
                                Text(kisi.kisiTel),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${kisi.kisiAd} silinsin mi?"),
                                  action: SnackBarAction(
                                    label: "Evet",
                                    onPressed: (){
                                      context.read<AnaSayfaCubit>().sil(kisi.kisiId);
                                      context.read<AnaSayfaCubit>().kisileriYukle();
                                    },
                                  ),
                                )
                            );
                          }, icon: const Icon(Icons.clear,color: Colors.black54,),)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa()))
              .then((value) {
            context.read<AnaSayfaCubit>().kisileriYukle();

          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
