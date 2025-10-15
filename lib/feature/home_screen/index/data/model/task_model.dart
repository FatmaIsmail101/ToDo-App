import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskModel {
  final String id;
  final String title;
  final bool isComplete;
  final Category category;
  final TaskPriority priority;
  final DateTime dateTime;

  TaskModel({
    String? id,
    required this.title,
    required this.isComplete,
    required this.category,
    required this.priority,
    required this.dateTime,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "isComplete": isComplete,
    "category": category.toJson(),
    "priority": priority.level,
    "dateTime": dateTime.toIso8601String(),
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"],
      category: Category.fromJson(json["category"]),
      dateTime: DateTime.parse(json["dateTime"]),
      isComplete: json["isComplete"],
      priority: TaskPriority(level: json["priority"], label: Icons.flag),
      id: json["id"],
    );
  }
}

class TaskPriority {
  final int level;
  final IconData label;

  TaskPriority({required this.level, required this.label});
}

class Category {
  final String name;
  Color color;
  IconData icon;

  Category({required this.name, required this.color, required this.icon});

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon.codePoint,
    "color": color.value,
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    color: Color(json["color"]),
    icon: IconData(json["icon"], fontFamily: "MaterialIcons"),
  );
}
