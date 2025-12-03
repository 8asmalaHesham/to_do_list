import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        title: const Text(
          txtTaskList,
          style: TextStyle(color: kBlack, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          _searchBar(),
          Expanded(
            child: Consumer<TaskViewModel>(
              builder: (_, vm, __) {
                final tasks = vm.tasks.where((t) {
                  if (_search.trim().isEmpty) return true;
                  final s = _search.toLowerCase();
                  return t.title.toLowerCase().contains(s) ||
                         t.description.toLowerCase().contains(s);
                }).toList();

                if (tasks.isEmpty) {
                  return const Center(
                      child: Text('No tasks yet',
                          style: TextStyle(color: Colors.grey)));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: tasks.length,
                  itemBuilder: (_, index) {
                    final task = tasks[index];
                    final realIndex = vm.tasks.indexOf(task);

                    return TaskCard(
                      task: task,
                      onToggleComplete: () => vm.toggleComplete(realIndex),
                      onDelete: () => vm.deleteTask(realIndex),
                      onMore: () => _openSheet(vm, realIndex),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: kWhite),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
      ),
    );
  }
 
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        decoration: InputDecoration(
          filled: true,
          fillColor: kPrimaryColor,
          prefixIcon: const Icon(Icons.search, color: kWhite),
          hintText: txtSearch,
          hintStyle: const TextStyle(color: Colors.white70),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _openSheet(TaskViewModel vm, int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                vm.deleteTask(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
