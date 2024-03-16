import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bootcamp/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi_bootcamp/repo/kisilerdao_repository.dart';

class AnaSayfaCubit extends Cubit<List<Kisiler>>{

  AnaSayfaCubit() : super(<Kisiler>[]);

  var _kRepo = KisilerDaoRepository();

  Future<void> kisileriYukle() async {
    List<Kisiler> tumKisiler = await _kRepo.kisileriYukle();
    emit(tumKisiler);
  }

  Future<void> ara(String aramaKelimesi) async {
    List<Kisiler> tumKisiler = await _kRepo.ara(aramaKelimesi);
    emit(tumKisiler);
  }

  Future<void> sil(int kisi_id) async {
    await _kRepo.sil(kisi_id);
    await _kRepo.kisileriYukle();

  }
  
  
}