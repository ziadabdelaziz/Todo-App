import 'package:flutter/material.dart';
import 'package:todo/bloc/bloc_exports.dart';

import '../models/task.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return  Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Text(
              'Add Task',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    var task = Task(
                      title: titleController.text,
                    );
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                )
              ],
            ),
            const SizedBox(height: 10),
          ]),
    );
  }
}
