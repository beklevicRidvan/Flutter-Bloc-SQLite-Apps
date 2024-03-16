import 'package:filmler_uygulamasi_bootcamp/ui/cubit/anasayfa_cubit.dart';
import 'package:filmler_uygulamasi_bootcamp/ui/cubit/anasayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/views/ana_sayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AnaSayfaCubit>(create: (context) => AnaSayfaCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
