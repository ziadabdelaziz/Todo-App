import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

import 'new_task_screen.dart';
import '../widgets/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  void startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const NewTaskScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks App'),
        actions: [
          IconButton(
            onPressed: () => startAddNewTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Chip(
              label: Text(
                'Tasks:',
              ),
            ),
          ),
          TasksList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
