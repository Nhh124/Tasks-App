import 'package:flutter/material.dart';

import '../../business_logic/bloc_exports.dart';
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
        overflow: TextOverflow.ellipsis,
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
