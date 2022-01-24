import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import 'completedtaskspage.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task list'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CompletedTaskPage())),
              icon: const Icon(Icons.arrow_forward))
        ],
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          final unfinishedTasks = tasks.where((task) => !task.isCompleted);

          return ListView(
            children: unfinishedTasks.map((task) => TaskCardWidget(task: task)).toList(),
          );
        },
      ),
      floatingActionButton: NewTaskModalWidget()
    );
  }
}