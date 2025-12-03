import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.startTime,
    this.endTime,
    this.isCompleted = false,
    String? id,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  String get formattedDate =>
      "${date.year}-${_two(date.month)}-${_two(date.day)}";

  String? get formattedStartTime =>
      startTime == null ? null : _formatTime(startTime!);

  String? get formattedEndTime =>
      endTime == null ? null : _formatTime(endTime!);

  static String _two(int n) => n < 10 ? "0$n" : "$n";

  static String _formatTime(TimeOfDay t) {
    final h = _two(t.hour);
    final m = _two(t.minute);
    return "$h:$m";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date.toIso8601String(),
      "startTime": startTime == null ? null : "${startTime!.hour}:${startTime!.minute}",
      "endTime": endTime == null ? null : "${endTime!.hour}:${endTime!.minute}",
      "isCompleted": isCompleted,
    };
  }


  factory TaskModel.fromMap(Map<String, dynamic> map) {
    TimeOfDay? parseTime(String? t) {
      if (t == null) return null;
      final parts = t.split(":");
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    return TaskModel(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      date: DateTime.parse(map["date"]),
      startTime: parseTime(map["startTime"]),
      endTime: parseTime(map["endTime"]),
      isCompleted: map["isCompleted"] ?? false,
    );
  }
}
