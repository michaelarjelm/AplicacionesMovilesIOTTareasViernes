import 'package:app_tareas/models/task.dart';
import 'package:app_tareas/models/task_filter.dart';
import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      title: "Jugar de todo un poco",
      note: "Tengo muchas ganas de jugar y de tomar coca cola",
      due: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      title: "Llevar a Tiana al veterinario",
      note: "Hay que llevar a ese perrito a control",
      due: DateTime.now().add(const Duration(days: 1)),
    ),
    Task(
      title: "Entregar la prueba",
      note:
          "Odio a este caballero, pero tengo que entregarle la prueba de móvil",
      due: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  String _query = "";

  TaskFilter _filter = TaskFilter.all;

  List<Task> get task => List.unmodifiable(_tasks);

  String get query => _query;

  TaskFilter get filter => _filter;

  List<Task> get filtered {
    final q = _query.trim().toLowerCase();
    return _tasks.where((t) {
      final byFilter = switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.pending => !t.done,
        TaskFilter.done => t.done,
      };

      ///REvisar
      final byQuery =
          q.isEmpty ||
          t.title.toLowerCase().contains(q) ||
          (t.note?.toLowerCase().contains(q) ?? false);
      return byFilter && byQuery;
    }).toList();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void toogle(Task task, bool done) {
    task.done = done;
    notifyListeners();
  }

  void add(String title, {String? note, DateTime? due}) {
    _tasks.insert(0, Task(title: title, note: note, due: due));
    notifyListeners();
  }

  void remove(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
