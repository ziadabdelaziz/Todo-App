import 'package:flutter/material.dart';
import 'package:todo/bloc/bloc_exports.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  TasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.allTasks;
        return Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) {
              var task = tasksList[index];
              return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.redAccent,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text(task.title),
                    trailing: Checkbox(
                        value: task.isDone,
                        onChanged: (value) {
                          context.read<TasksBloc>().add(UpdateTask(task: task));
                        }),
                  ),
                  onDismissed: (direction) {
                    context.read<TasksBloc>().add(DeleteTask(task: task));
                  });
            }),
            itemCount: tasksList.length,
          ),
        );
      },
    );
  }
}
