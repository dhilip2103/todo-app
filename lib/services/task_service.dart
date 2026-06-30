// lib/services/task_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  // ✅ Add Task
  Future<String?> addTask({
    required String title,
    required String description,
  }) async {
    try {
      TaskModel task = TaskModel(
        taskId: '',
        title: title.trim(),
        description: description.trim(),
        status: false,
        createdAt: DateTime.now(),
        userId: _uid,
      );

      await _firestore.collection('tasks').add(task.toMap());
      return null;
    } catch (e) {
      return 'Failed to add task.';
    }
  }

  // ✅ Get Tasks (real-time stream for current user)
  // FIX: Removed .orderBy() from the Firestore query — combining .where()
  // with .orderBy() on a different field requires a composite index in
  // Firestore. Without that index, the query silently fails and no tasks
  // are returned (even though the task WAS saved). Sorting is now done
  // client-side in Dart instead, so no index is required at all.
  Stream<List<TaskModel>> getTasks() {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) {
      final tasks = snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
          .toList();
      // Sort newest-first in Dart (no Firestore index needed)
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tasks;
    });
  }

  // ✅ Update Task
  Future<String?> updateTask({
    required String taskId,
    required String title,
    required String description,
  }) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'title': title.trim(),
        'description': description.trim(),
      });
      return null;
    } catch (e) {
      return 'Failed to update task.';
    }
  }

  // ✅ Delete Task
  Future<String?> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      return null;
    } catch (e) {
      return 'Failed to delete task.';
    }
  }

  // ✅ Toggle Task Status (Complete / Pending)
  Future<String?> toggleTaskStatus(String taskId, bool currentStatus) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'status': !currentStatus,
      });
      return null;
    } catch (e) {
      return 'Failed to update task status.';
    }
  }
}
