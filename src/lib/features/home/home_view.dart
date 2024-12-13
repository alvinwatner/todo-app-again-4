import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_app_v4/features/home/home_viewmodel.dart';
import 'package:todo_app_v4/features/home/widgets/todo_item.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: viewModel.showDialog,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: viewModel.toggleTodoComplete,
                  onDelete: viewModel.deleteTodo,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
