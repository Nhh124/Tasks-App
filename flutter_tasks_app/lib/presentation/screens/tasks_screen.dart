import 'package:flutter/material.dart';

import '../../business_logic/bloc_exports.dart';
import '../../data/models/task.dart';
import '../widgets/task_list.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});
  static const routeName = 'task_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskstate) {
        List<Task> tasklist = taskstate.pendingTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Total Task pending: ${tasklist.length} | Task Completed: ${taskstate.completedTasks.length}',
                ),
              ),
            ),
            TaskList(tasklist: tasklist),
          ],
        );
      },
    );
  }
}
