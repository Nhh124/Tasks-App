import 'package:flutter/material.dart';

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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ],
          ),
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
