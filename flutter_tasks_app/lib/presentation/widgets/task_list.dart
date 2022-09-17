import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/presentation/widgets/task_tile.dart';

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
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: tasklist
              .map(
                (task) => ExpansionPanelRadio(
                  value: task.id,
                  headerBuilder: (context, isOpen) => TaskTile(task: task),
                  body: ListTile(
                    title: SelectableText.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Text:\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: task.title),
                          const TextSpan(
                            text: '\n\nDescription\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: task.description),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// Expanded(
//       child: ListView.builder(
//         itemCount: tasklist.length,
//         itemBuilder: (context, taskindex) {
//           var task = tasklist[taskindex];
//           return TaskTile(task: task);
//         },
//       ),
//     );