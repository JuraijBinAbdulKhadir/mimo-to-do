import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  // Constructor to initialize TaskProvider
  TaskProvider();

  // Fetch all tasks for a specific category
  Future<void> fetchTasks(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('categories')
          .doc(categoryId)
          .collection('tasks')
          .get();
      _tasks = snapshot.docs.map((doc) {
        return Task(
          id: doc.id,
          name: doc['name'],
          isCompleted: doc['isCompleted'],
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      // Handle errors
      print("Error fetching tasks: $e");
      throw e;
    }
  }

  // Add a new task to a category
  Future<void> addTask(String categoryId, String taskName) async {
    try {
      DocumentReference docRef = await _db
          .collection('categories')
          .doc(categoryId)
          .collection('tasks')
          .add({
        'name': taskName,
        'isCompleted': false,
      });

      // Create a new Task object with the Firestore document ID
      Task newTask = Task(
        id: docRef.id, // Use the newly created document ID
        name: taskName,
        isCompleted: false,
      );

      _tasks.add(newTask); // Add the task to local list
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      print("Error adding task: $e");
      throw e;
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(String categoryId, String taskId, bool isCompleted) async {
    try {
      await _db
          .collection('categories')
          .doc(categoryId)
          .collection('tasks')
          .doc(taskId)
          .update({
        'isCompleted': !isCompleted,
      });

      int index = _tasks.indexWhere((task) => task.id == taskId);
      if (index != -1) {
        _tasks[index].isCompleted = !isCompleted; // Update local task state
      }
      notifyListeners();
    } catch (e) {
      print("Error toggling task completion: $e");
      throw e;
    }
  }
}

class Task {
  final String id;
  final String name;
  bool isCompleted;

  Task({required this.id, required this.name, required this.isCompleted});
}
