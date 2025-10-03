import 'package:app_tareas/widgets/taskWidgets/new_task_sheet.dart';
import 'package:flutter/material.dart';

class NewTaskFab extends StatelessWidget {
  const NewTaskFab({
    super.key, // Key opcional para identificar el widget en el árbol
    required this.onSubmit, // Callback requerido: recibe (title, note, due)
    this.onCreated, // Callback opcional tras crear (p. ej., mostrar SnackBar)
    this.labelText = 'Nueva', // Texto por defecto del FAB
    this.icon = Icons.add, // Ícono por defecto del FAB
  });

  final void Function(String title, String? note, DateTime? due)
  onSubmit; // Define parámetros a propagar
  final void Function(BuildContext context)?
  onCreated; // Callback opcional ejecutado si el sheet retorna éxito
  final String labelText; // Texto visible en el FAB
  final IconData icon; // Ícono visible en el FAB

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(icon),
      label: Text(labelText),
      onPressed: () async {
        final created = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (ctx) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: NewTaskSheet(
              onSubmit: (title, note, due) {
                onSubmit(title, note, due);
                Navigator.pop(ctx, true);
              },
            ),
          ),
        );
        if ((created ?? false) && onCreated != null) {
          onCreated!(context);
        }
      },
    );
  }
}
