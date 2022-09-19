import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/presentation/screens/my_drawer.dart';

import '../../business_logic/bloc_exports.dart';
import '../widgets/task_list.dart';

class RecycleBinSCreen extends StatelessWidget {
  const RecycleBinSCreen({super.key});
  static const routeName = 'recyclebin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () => context.read<TaskBloc>().add(
                          DeleteAllTask(),
                        ),
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete forever'),
                    ),
                  ),
                ],
              )
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text('Total tasks: ${state.removedTasks.length}'),
                ),
              ),
              TaskList(tasklist: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
