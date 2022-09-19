// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import '../../../data/models/task.dart';
import '/business_logic/bloc_exports.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTasks>(_onRemoveTasks);
    on<MarkFavoriteTaksOrNot>(_onMarkFavoriteTaskOrNot);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };

    emit(TaskState(
      pendingTasks: pendingTasks,
      removedTasks: state.removedTasks,
      completedTasks: completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  void _onRemoveTasks(RemoveTasks event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.pendingTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDelete: true))));
  }

  void _onMarkFavoriteTaskOrNot(
      MarkFavoriteTaksOrNot event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (task.isDone == false) {
      if (task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(task);

        emit(TaskState(
          favoriteTasks: List.from(favoriteTasks)
            ..insert(0, task.copyWith(isFavorite: true)),
          pendingTasks: List.from(pendingTasks)
            ..remove(task)
            ..insert(taskIndex, task.copyWith(isFavorite: true)),
        ));
      } else {
        var taskIndex = pendingTasks.indexOf(task);

        emit(TaskState(
          favoriteTasks: List.from(favoriteTasks)..remove(task),
          pendingTasks: List.from(pendingTasks)
            ..remove(task)
            ..insert(taskIndex, task.copyWith(isFavorite: false)),
        ));
      }
    } else {
      if (task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: true));
        emit(TaskState(
            favoriteTasks: List.from(favoriteTasks)
              ..insert(0, task.copyWith(isFavorite: true))));
      } else {
        var taskIndex = completedTasks.indexOf(task);
        pendingTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));
        emit(TaskState(favoriteTasks: List.from(favoriteTasks)..remove(task)));
      }
    }
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final newtask = event.newTask;
    final oldtask = event.oldTask;

    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      emit(TaskState(
        favoriteTasks: favoriteTasks
          ..remove(oldtask)
          ..insert(0, newtask),
      ));
    }
    if (event.oldTask.isDone == true) {
      emit(TaskState(
        completedTasks: state.completedTasks..remove(oldtask),
        pendingTasks: List.from(state.pendingTasks)
          ..remove(oldtask)
          ..insert(0, newtask),
      ));
    }
    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)
          ..remove(oldtask)
          ..insert(0, newtask),
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
          0,
          event.task.copyWith(
            isDelete: false,
            isDone: false,
            isFavorite: false,
          ),
        ),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      removedTasks: List.from(state.removedTasks)..clear(),
      pendingTasks: state.pendingTasks,
      favoriteTasks: state.favoriteTasks,
      completedTasks: state.completedTasks,
    ));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
