import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../boxes.dart';
import '../widgets.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({Key? key}) : super(key: key);

  @override
  _CompletedTaskPageState createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Completed Task List'),
        ),
        body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Boxes.getTasks().listenable(),
          builder: (context, box, _) {
            final tasks = box.values.toList().cast<Task>();
            final finishedTasks = tasks.where((task) => task.isCompleted);

            return ListView(
              children: finishedTasks.map((task) =>
                  CompletedTaskWidget(task: task)).toList(),
            );
          },
        ),
    );
  }
}

