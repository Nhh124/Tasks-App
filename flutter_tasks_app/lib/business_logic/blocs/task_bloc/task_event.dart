// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  const UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class RemoveTasks extends TaskEvent {
  final Task task;
  const RemoveTasks({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class MarkFavoriteTaksOrNot extends TaskEvent {
  final Task task;

  const MarkFavoriteTaksOrNot({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class EditTask extends TaskEvent {
  final Task newTask;
  final Task oldTask;
  const EditTask({
    required this.newTask,
    required this.oldTask,
  });

  @override
  List<Object> get props => [newTask, oldTask];
}

class RestoreTask extends TaskEvent {
  final Task task;

  const RestoreTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteAllTask extends TaskEvent {}
