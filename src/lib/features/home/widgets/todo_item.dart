import 'package:flutter/material.dart';
import 'package:todo_app_v4/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          'Created: ${todo.createdAt.toString().split('.').first}',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
