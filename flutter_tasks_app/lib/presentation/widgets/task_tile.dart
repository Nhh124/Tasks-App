import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/task_bloc.dart';
import '../../data/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  void _removeOrdeleteTask(BuildContext context, Task task) {
    task.isDelete!
        ? context.read<TaskBloc>().add(DeleteTask(task: task))
        : context.read<TaskBloc>().add(RemoveTasks(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) {
          context.read<TaskBloc>().add(
                UpdateTask(task: task),
              );
        },
      ),
      onLongPress: () => _removeOrdeleteTask(
        context,
        task,
      ),
      // onLongPress: () => context.read<TaskBloc>().add(DeleteTask(task: task)),
    );
  }
}
