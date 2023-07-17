import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/models/task.dart';

import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>((event, emit) => _addTask(event, emit));
    on<UpdateTask>((event, emit) => _updateTask(event, emit));
    on<DeleteTask>((event, emit) => _deleteTask(event, emit));
  }

  _addTask(AddTask event, Emitter emit) {
    final state = this.state;
    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
    ));
    retrieve();
  }

  _updateTask(UpdateTask event, Emitter emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    emit(TasksState(allTasks: allTasks));
  }

  _deleteTask(DeleteTask event, Emitter emit) {
    final state = this.state;
    emit(TasksState(
      allTasks: List.from(state.allTasks)..remove(event.task),
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }

  Future<void> retrieve() async {
    final locStorage = HydratedBloc.storage;

    final value = await locStorage.read;
    print(value);
  }
}
