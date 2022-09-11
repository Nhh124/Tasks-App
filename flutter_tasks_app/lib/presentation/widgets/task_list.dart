import 'package:flutter/material.dart';
import '/business_logic/bloc_exports.dart';

import '../../data/models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasklist,
  }) : super(key: key);

  final List<Task> tasklist;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasklist.length,
        itemBuilder: (context, taskindex) {
          var task = tasklist[taskindex];
          print(task);
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                context.read<TaskBloc>().add(
                      UpdateTask(task: task),
                    );
              },
            ),
            onLongPress: () =>
                context.read<TaskBloc>().add(DeleteTask(task: task)),
          );
        },
      ),
    );
  }
}
