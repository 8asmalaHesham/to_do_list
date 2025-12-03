import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => List.unmodifiable(_tasks);

  TaskViewModel() {
    _loadTasks(); // تحميل البيانات عند تشغيل الأبلكيشن
  }

  // ------------ Shared Preferences (تحميل + حفظ) ------------

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("tasks");

    if (jsonString == null) return;

    final List decoded = jsonDecode(jsonString);

    _tasks.clear();
    _tasks.addAll(decoded.map((e) => TaskModel.fromMap(e)));

    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_tasks.map((e) => e.toMap()).toList());
    await prefs.setString("tasks", jsonString);
  }

  // ---------------- CRUD METHODS ----------------

  void addTask(TaskModel task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  void toggleComplete(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    _saveTasks();
    notifyListeners();
  }

  void updateTask(int index, TaskModel updatedTask) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks[index] = updatedTask;
    _saveTasks();
    notifyListeners();
  }

  void clearAll() {
    _tasks.clear();
    _saveTasks();
    notifyListeners();
  }
}

