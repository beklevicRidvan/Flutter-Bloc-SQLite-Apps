import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part "task_model.g.dart";


@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
   String id;

  @HiveField(1)
   String isim;

  @HiveField(2)
   DateTime createdAt;

  @HiveField(3)
   bool isCompleted;

  Task({required this.id, required this.isim, required this.createdAt, required this.isCompleted});


  factory Task.create({required String name,required DateTime createdAt}){
    return Task(id: const Uuid().v1(), isim: name, createdAt: createdAt, isCompleted: false);
  }



  static String timeFormat(DateTime time){
    String period = (time.hour < 12) ? 'AM':'PM';
    return "${time.hour}:${time.minute} $period";
  }



}