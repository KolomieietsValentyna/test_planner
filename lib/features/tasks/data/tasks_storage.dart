import 'dart:convert';

import 'package:test_planner/common/services/storage_service.dart';
import 'package:test_planner/features/tasks/entity/task_model.dart';

class TasksStorage {
  // Create SecureStorageService object which allows us interact with the internal 
  //memory of the device
  final _storage = SecureStorageService();

  // Create key by which the application will interact with the internal 
  //memory of the device
  final String key = 'tasks/';

  // Put or rewrite information about tasks to storage by key using SecureStorageService
  Future<void> write(List<TaskModel> data) async {
    final List<Map<String, dynamic>> tasks = [];
    for (TaskModel item in data) {
      tasks.add(item.toJson());
    }
    await _storage.write(key, json.encode(tasks));
  }

  // Get information from device storage by key
  Future<List<TaskModel>> read() async {
    final String? jsonData = await _storage.read(key);
    if (jsonData == null) return [];

    List<dynamic> data = jsonDecode(jsonData);

    final List<TaskModel> tasks = [];
    for (Map<String, dynamic> item in data) {
      tasks.add(TaskModel.fromJson(item));
    }
    return tasks;
  }
}
