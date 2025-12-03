import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../models/task.dart';
import '../../utils/date_utils.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggleComplete;
  final VoidCallback onDelete;
  final VoidCallback? onMore;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onDelete,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(kCardRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/icon1.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    fontSize: 16,
                  ),
                ),
              ),
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) => onToggleComplete(),
                activeColor: kPrimaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            task.description,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            formatDate(task.date),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
