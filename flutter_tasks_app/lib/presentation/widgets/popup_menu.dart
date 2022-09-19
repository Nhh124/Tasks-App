// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../data/models/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key? key,
    required this.cancelOrDeleteCallback,
    required this.likeOrNot,
    required this.editTaskCallBack,
    required this.restoreTaskCallBack,
    required this.task,
  }) : super(key: key);

  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrNot;
  final VoidCallback editTaskCallBack;
  final VoidCallback restoreTaskCallBack;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDelete == false
          ? (context) => [
                PopupMenuItem(
                  onTap: null,
                  child: TextButton.icon(
                    onPressed: editTaskCallBack,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  onTap: likeOrNot,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavorite == false
                        ? const Text('Add to \nBookmarks')
                        : const Text('Remove from \nBookmarks'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                )
              ]
          : (context) => [
                PopupMenuItem(
                  onTap: restoreTaskCallBack,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  onTap: cancelOrDeleteCallback,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete forever'),
                  ),
                ),
              ],
    );
  }
}
