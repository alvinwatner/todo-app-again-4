import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:todo_app_v4/app/app.bottomsheets.dart';
import 'package:todo_app_v4/app/app.dialogs.dart';
import 'package:todo_app_v4/app/app.locator.dart';
import 'package:todo_app_v4/features/home/home_repository.dart';
import 'package:todo_app_v4/models/todo_model.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _repository = HomeRepository();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> initialize() async {
    await _loadTodos();
  }

  Future<void> _loadTodos() async {
    setBusy(true);
    try {
      _todos = await _repository.getTodos();
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      setBusy(false);
    }
  }

  Future<void> showAddTodoSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add Todo',
      description: 'Enter a new todo item',
    );

    if (response?.confirmed == true && response?.data != null) {
      await addTodo(response!.data as String);
    }
  }

  Future<void> addTodo(String title) async {
    final todo = TodoModel(
      id: DateTime.now().toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    await _repository.addTodo(todo);
    await _loadTodos();
  }

  Future<void> toggleTodoComplete(String id) async {
    await _repository.toggleTodoComplete(id);
    await _loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
    await _loadTodos();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Todo App',
      description: 'A simple todo app built with Stacked architecture.',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add Todo',
      description: 'Enter a new todo item',
    );
  }
}
