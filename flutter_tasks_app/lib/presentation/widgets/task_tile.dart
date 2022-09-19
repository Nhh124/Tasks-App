import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/presentation/screens/edit_tasks_screen.dart';
import 'package:flutter_tasks_app/presentation/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditTaskScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat().add_yMEd().add_Hms().format(
                              DateTime.parse(task.date),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<TaskBloc>().add(
                        UpdateTask(task: task),
                      );
                },
              ),
              PopupMenu(
                cancelOrDeleteCallback: () =>
                    _removeOrdeleteTask(context, task),
                likeOrNot: () => context
                    .read<TaskBloc>()
                    .add(MarkFavoriteTaksOrNot(task: task)),
                task: task,
                editTaskCallBack: () {
                  Navigator.of(context).pop();

                  _editTask(context);
                },
                restoreTaskCallBack: () =>
                    context.read<TaskBloc>().add(RestoreTask(task: task)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ListTile(
//       title: Text(
//         task.title,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           decoration: task.isDone! ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: Checkbox(
//         value: task.isDone,
//         onChanged: (value) {
//           context.read<TaskBloc>().add(
//                 UpdateTask(task: task),
//               );
//         },
//       ),
//       onLongPress: () => _removeOrdeleteTask(
//         context,
//         task,
//       ),
//        onLongPress: () => context.read<TaskBloc>().add(DeleteTask(task: task)),
//     );