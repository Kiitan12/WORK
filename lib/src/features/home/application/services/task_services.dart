import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/globals.dart';

import '../../domain/model/task.dart';

// Service class for handling tasks
class TaskServices extends StateNotifier<bool> {
  final firestore = FirebaseFirestore.instance;

  TaskServices() : super(false);
// Method to retrieve tasks of a specified type from Firestore
  Future<List<Task>> getTasks(String taskType) async {
    try {
      final snapshot = await firestore.collection(taskType).get();
// Map snapshot documents to Task objects and convert to list
      final trendingTask =
          snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
      return trendingTask;
    } catch (e) {
      throw Exception(e);
    }
  }

  // method to upload all the tasks to the firestore
  Future<void> uploadTask(List<Task> task) async {
    try {
      for (final t in task) {
        print('Uploading task: ${t.id}');
        await firestore.collection('trendingTasks').add(t.toJson());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Method to submit interest in a task to Firestore
  Future<void> submitInterest(
    String taskId,
    String response1,
    String response2,
    String name,
  ) async {
    try {
      state = true;
      await firestore.collection('interests').add({
        'task_id': taskId,
        'response': response1,
        'experience': response2,
        'name': name,
      }); // Add interest data to Firestore collection
      navigatorKey.currentState!.pop();
      snackBarKey.currentState!.showSnackBar(const SnackBar(
        content: Text('Interest submitted successfully'),
      ));
      state = false;
    } catch (e) {
      state = false;
      throw Exception(e);
    }
  }
}
