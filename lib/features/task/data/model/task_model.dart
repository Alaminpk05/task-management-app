import 'package:objectbox/objectbox.dart';

@Entity()
class TaskModel {
  @Id()
  int id = 0;
  final String time;
  final String text;
  final String date;
  final bool isComplete;

  TaskModel({
     this.id=0,
    required this.time,
    required this.text,
    required this.date,
    required this.isComplete,
  });

  // copyWith method
  TaskModel copyWith({
    int? id,
    String? time,
    String? text,
    String? date,
    bool? isComplete,
  }) {
    return TaskModel(
      time: time ?? this.time,
      text: text ?? this.text,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
      id: id ?? this.id,
    );
  }


}
