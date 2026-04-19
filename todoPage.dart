import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_cubit.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Cubit')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    context.read<TodoCubit>().addTask(controller.text);
                    controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoCubit, List<Map<String, dynamic>>>(
              builder: (context, tasks) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet'));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];

                    return ListTile(
                      leading: IconButton(
                        icon: Icon(
                          (tasks[index]['isDone'] as bool)
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: (tasks[index]['isDone'] as bool)
                              ? Colors.green
                              : Colors.grey,
                        ),
                        onPressed: () {
                          context.read<TodoCubit>().toggleTask(index);
                        },
                      ),
                      title: Text(
                        tasks[index]['text'] as String,
                        style: TextStyle(
                          decoration: (tasks[index]['isDone'] as bool)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoCubit>().removeTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
