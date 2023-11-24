import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  NotesModel({
    required this.title,
    required this.des,
    required this.date,
    required this.cat,
    required this.color,
  });
  @HiveField(1)
  String title;
  @HiveField(2)
  String des;
  @HiveField(3)
  String date;
  @HiveField(4)
  String cat;
  @HiveField(5)
  int color;
}
