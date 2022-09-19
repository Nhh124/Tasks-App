import 'package:flutter/material.dart';

import '../../business_logic/bloc_exports.dart';
import '../../data/models/task.dart';
import '../widgets/task_list.dart';

class FavoriteTasksScreen extends StatelessWidget {
  const FavoriteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskstate) {
        List<Task> tasklist = taskstate.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text('Total Task: ${tasklist.length}'),
              ),
            ),
            TaskList(tasklist: tasklist),
          ],
        );
      },
    );
  }
}
