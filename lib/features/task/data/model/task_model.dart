import 'package:objectbox/objectbox.dart';

@Entity()
class TaskModel {
  @Id()
  int id = 0;
  final String time;
  final String text;
  final String date;
  bool isComplete;
  bool isArchive;

  TaskModel({
    this.id = 0,
    required this.time,
    required this.text,
    required this.date,
    this.isArchive=false,
    this.isComplete=false,
  
  });

  TaskModel copyWith({
    int? id,
    String? time,
    String? text,
    String? date,
    bool? isComplete,
    bool? isArchive,
  }) {
    return TaskModel(
      time: time ?? this.time,
      text: text ?? this.text,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
      id: id ?? this.id, isArchive: isArchive??this.isArchive,
    );
  }
}
