// lib/models/task_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String taskId;
  final String title;
  final String description;
  final bool status; // false = pending, true = completed
  final DateTime createdAt;
  final String userId;

  TaskModel({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.userId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String taskId) {
    return TaskModel(
      taskId: taskId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  TaskModel copyWith({
    String? title,
    String? description,
    bool? status,
  }) {
    return TaskModel(
      taskId: taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt,
      userId: userId,
    );
  }
}
