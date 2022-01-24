import 'package:hive/hive.dart';
import 'package:flutter_todo/model/task.dart';

class Boxes {
  static Box<Task> getTasks() =>
      Hive.box<Task>('tasks');
}