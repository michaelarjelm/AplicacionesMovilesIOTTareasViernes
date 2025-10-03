import 'package:app_tareas/models/task.dart';
import 'package:app_tareas/widgets/taskWidgets/swipe_bg.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDismissed,
    required this.swipeColor,
    this.dateText,
    this.itemKey,
  });

  final Task task;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDismissed;
  final Color swipeColor;
  final String? dateText;
  final Object? itemKey;

  @override
  Widget build(BuildContext context) {
    final k = itemKey ?? '${task.title}-${task.hashCode}';
    return Dismissible(
      key: ValueKey(k),
      background: SwipeBg(alineacion: Alignment.centerLeft, color: swipeColor),
      secondaryBackground: SwipeBg(
        alineacion: Alignment.centerRight,
        color: swipeColor,
      ),
      onDismissed: (_) => onDismissed(),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: CheckboxListTile(
          value: task.done,
          onChanged: (v) => onToggle(v ?? false),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.note != null && task.note!.isNotEmpty) Text(task.note!),
              if (dateText != null)
                Row(
                  children: [
                    const Icon(Icons.event, size: 16),
                    const SizedBox(width: 6),
                    Text(dateText!),
                  ],
                ),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
          secondary: const Icon(Icons.drag_handle),
        ),
      ),
    );
  }
}
