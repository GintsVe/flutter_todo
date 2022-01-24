import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'boxes.dart';
import 'model/task.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    Key? key,
    required this.task
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                EditTaskModalWidget(task: task,),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () => deleteTask(task),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => taskCompleted(task),
                  child: const Text("Complete"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }

  void taskCompleted(Task task) {
    task.isCompleted = true;

    task.save();
  }
}

class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({
    Key? key,
    required this.task
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => deleteTask(task),
                  child: const Text("Remove"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(Task task) {
    task.delete();
  }
}


class NewTaskModalWidget extends StatelessWidget {
  NewTaskModalWidget({Key? key}) : super(key: key);

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children:  <Widget>[
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            decoration: const InputDecoration(
                              hintText: "Task title",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskTitleController,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Task description",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskDescriptionController,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () => {
                                taskTitleController.text = "",
                                taskDescriptionController.text = "",
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('New Task'),
                              onPressed: () => {
                                addTask(taskTitleController.text, taskDescriptionController.text),
                                taskTitleController.text = "",
                                taskDescriptionController.text = "",
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addTask(String title, String description) {
    final task = Task()
      ..title = title == "" ? "(Untitled)" : title
      ..description = description == "" ? "(No description)" : description
      ..isCompleted = false;

    final box = Boxes.getTasks();
    box.add(task);
  }
}

class EditTaskModalWidget extends StatelessWidget {
  EditTaskModalWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Edit'),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children:  <Widget>[
                          TextFormField (
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskTitleController..text = task.title,
                          ),
                          const SizedBox(height: 10),
                          TextFormField (
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0x9EB1B1B1),
                              filled: true,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: taskDescriptionController..text = task.description,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () => {
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              child: const Text('Edit Task'),
                              onPressed: () => {
                                editTask(task),
                                Navigator.pop(context)
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void editTask(Task task) {
    task.title = taskTitleController.text;
    task.description = taskDescriptionController.text;

    task.save();
  }
}