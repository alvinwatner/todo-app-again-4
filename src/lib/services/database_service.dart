import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_v4/models/todo_model.dart';

class DatabaseService {
  static const String _todosKey = 'todos';

  Future<List<TodoModel>> getTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todosJson = prefs.getStringList(_todosKey) ?? [];
      return todosJson
          .map((todo) => TodoModel.fromJson(json.decode(todo)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todosJson =
          todos.map((todo) => json.encode(todo.toJson())).toList();
      await prefs.setStringList(_todosKey, todosJson);
    } catch (e) {
      // Handle error appropriately
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final todos = await getTodos();
    todos.add(todo);
    await saveTodos(todos);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      await saveTodos(todos);
    }
  }

  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    todos.removeWhere((todo) => todo.id == id);
    await saveTodos(todos);
  }

  Future<void> toggleTodoComplete(String id) async {
    final todos = await getTodos();
    final index = todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = todos[index];
      todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      await saveTodos(todos);
    }
  }
}
