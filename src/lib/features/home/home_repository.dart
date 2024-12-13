import 'package:todo_app_v4/app/app.locator.dart';
import 'package:todo_app_v4/models/todo_model.dart';
import 'package:todo_app_v4/services/database_service.dart';

class HomeRepository {
  final _databaseService = locator<DatabaseService>();

  Future<List<TodoModel>> getTodos() async {
    return await _databaseService.getTodos();
  }

  Future<void> addTodo(TodoModel todo) async {
    await _databaseService.addTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _databaseService.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _databaseService.deleteTodo(id);
  }

  Future<void> toggleTodoComplete(String id) async {
    await _databaseService.toggleTodoComplete(id);
  }
}
