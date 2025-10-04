import 'package:app_tareas/controller/task_controller.dart';
import 'package:app_tareas/utils/date_utils.dart';
import 'package:app_tareas/widgets/taskWidgets/empty_state.dart';
import 'package:app_tareas/widgets/taskWidgets/filter_chips_row.dart';
import 'package:app_tareas/widgets/taskWidgets/filter_menu_button.dart';
import 'package:app_tareas/widgets/taskWidgets/new_task_fab.dart';
import 'package:app_tareas/widgets/taskWidgets/search_field.dart';
import 'package:app_tareas/widgets/taskWidgets/task_list_view.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final TaskController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = TaskController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final items = _ctrl.filtered;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tareas"),
            actions: [
              FilterMenuButton(value: _ctrl.filter, onChanged: _ctrl.setFilter),
            ],
          ),
          floatingActionButton: NewTaskFab(
            onSubmit: (title, note, due) =>
                _ctrl.add(title, note: note, due: due),
            onCreated: (ctx) => ScaffoldMessenger.of(
              ctx,
            ).showSnackBar(const SnackBar(content: Text("Tarea creada"))),
          ),
          body: SafeArea(
            child: Column(
              children: [
                SearchField(onChanged: _ctrl.setQuery),
                FilterChipsRow(
                  value: _ctrl.filter,
                  onChanged: _ctrl.setFilter,
                  color: Colors.red,
                ),
                const Divider(height: 1),
                Expanded(
                  child: items.isEmpty
                      ? const EmptyState()
                      : TaskListView(
                          items: items,
                          onToggle: (task, done) => _ctrl.toogle(task, done),
                          onDelete: (task) {
                            _ctrl.remove(task);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Tarea eliminada")),
                            );
                          },
                          dateFormatter: formatShortDate,
                          swipeColor: Colors.black,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
