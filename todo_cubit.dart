import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<Map<String, dynamic>>> {
  TodoCubit() : super(const []);

  void addTask(String task) {
    if (task.trim().isEmpty) return;

    emit([
      ...state,
      {
        'text': task.trim(),
        'isDone': false,
      }
    ]);
  }

  void toggleTask(int index) {
    final updated = List<Map<String, dynamic>>.from(state);

    updated[index] = {
      'text': updated[index]['text'],
      'isDone': !(updated[index]['isDone'] as bool),
    };

    emit(updated);
  }

  void removeTask(int index) {
    final updated = List<Map<String, dynamic>>.from(state)
      ..removeAt(index);

    emit(updated);
  }
}