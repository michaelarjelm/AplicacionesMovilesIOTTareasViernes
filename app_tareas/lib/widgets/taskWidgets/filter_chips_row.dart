import 'package:app_tareas/models/task_filter.dart';
import 'package:flutter/material.dart';

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({
    super.key,
    required this.value,
    required this.onChanged,
    this.color,
  });

  final TaskFilter value;
  final ValueChanged<TaskFilter> onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final active = color ?? Theme.of(context).colorScheme.primary;
    ChoiceChip chip(String label, TaskFilter filter) => ChoiceChip(
      label: Text(
        label,
        style: TextStyle(color: value == filter ? Colors.white : Colors.black),
      ),
      selected: value == filter,
      selectedColor: active,
      onSelected: (_) => onChanged(filter),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Wrap(
        spacing: 0,
        children: [
          chip("Todas", TaskFilter.all),
          chip("Pendientes", TaskFilter.pending),
          chip("Terminadas", TaskFilter.done),
        ],
      ),
    );
  }
}
