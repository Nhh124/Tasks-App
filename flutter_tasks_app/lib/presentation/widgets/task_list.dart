import 'package:flutter/material.dart';
import '/presentation/widgets/task_tile.dart';

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
          return TaskTile(task: task);
        },
      ),
    );
  }
}
