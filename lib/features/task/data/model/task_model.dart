import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  @Id()
  int id=0;
  final String time;
  final String text;
  final String date;
  final bool isComplete;

  Task({
    required this.id,
    required this.time,
    required this.text,
    required this.date,
    required this.isComplete,
  });

  // copyWith method
  Task copyWith({
    int? id,
    String? time,
    String? text,
    String? date,
    bool? isComplete,
  }) {
    return Task(
      
      time: time ?? this.time,
      text: text ?? this.text,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete, id: id??this.id,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, time: $time, text: $text, date: $date, isComplete: $isComplete)';
  }
}
