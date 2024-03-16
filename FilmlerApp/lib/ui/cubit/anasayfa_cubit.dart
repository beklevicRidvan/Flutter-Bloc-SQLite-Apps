import 'package:filmler_uygulamasi_bootcamp/data/repo/filmlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/filmler.dart';

class AnaSayfaCubit extends Cubit<List<Filmler>>{

  AnaSayfaCubit():super(<Filmler>[]);

  final _fRepo = FilmlerDaoRepository();

  Future<void> filmleriYukle() async {
    var tumFilmler = await _fRepo.filmleriYukle();
    emit(tumFilmler);
  }


}