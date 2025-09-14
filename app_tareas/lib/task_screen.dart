import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tareas"),
      ),
      body: const Center(
        child: Text("Aquí irá la lista de tareas"),
      ),floatingActionButton: FloatingActionButton(
        onPressed: () {          
        },child: const Icon(Icons.add),
      ),
    );
  }
}