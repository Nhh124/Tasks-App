import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/presentation/screens/complete_tasks_screen.dart';
import 'package:flutter_tasks_app/presentation/screens/favorite_tasks_screen.dart';
import '/presentation/screens/tasks_screen.dart';
import '/presentation/screens/my_drawer.dart';

import 'add_tasks_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const routeName = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pagedetail = [
    {
      'pageName': const PendingTasksScreen(),
      'title': 'Pending Tasks',
    },
    {
      'pageName': const CompleteTasksScreen(),
      'title': 'Complete Tasks',
    },
    {
      'pageName': const FavoriteTasksScreen(),
      'title': 'Favorite Tasks',
    },
  ];

  var selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagedetail[selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: _pagedetail[selectedPageIndex]['pageName'],
      floatingActionButton: selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (value) {
          setState(() {
            selectedPageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.incomplete_circle_sharp),
            label: 'Pending Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Complete Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite Tasks',
          ),
        ],
      ),
    );
  }
}
