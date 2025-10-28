import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

final addTaskProvider = StateNotifierProvider<AddTaskNotifier, AddTaskState>(
  (ref) => AddTaskNotifier(ref),
);

class AddTaskState {
  final String title;
  final String description;
  final DateTime? dateTime;
  final Category? category;
  final TaskPriority? priority;
  final bool isComplete;

  AddTaskState({
    this.title = '',
    this.description = '',
    this.dateTime,
    this.priority,
    this.category,
    this.isComplete = false,
  });

  AddTaskState copyWith({
    String? title,
    String? description,
    DateTime? dateTime,
    Category? category,
    TaskPriority? priority,
    bool? isComplete,
  }) {
    return AddTaskState(
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      category: category ?? this.category,
      isComplete: isComplete ?? this.isComplete,
      priority: priority ?? this.priority,
    );
  }
}

class AddTaskNotifier extends StateNotifier<AddTaskState> {
  final Ref ref;

  AddTaskNotifier(this.ref) : super(AddTaskState());

  void updateTitle(String title) => state = state.copyWith(title: title);

  void updateDescription(String description) =>
      state = state.copyWith(description: description);

  void updateCategory(Category category) =>
      state = state.copyWith(category: category);

  void updatePriority(TaskPriority priority) =>
      state = state.copyWith(priority: priority);

  void updateDateTime(DateTime date) => state = state.copyWith(dateTime: date);

  Future<TaskModel?> saveTask() async {
    if (state.title.isEmpty ||
        state.description.isEmpty ||
        state.priority == null ||
        state.category == null ||
        state.dateTime == null) {
      return null;
    }
    final task = TaskModel(
      title: state.title,
      isComplete: state.isComplete,
      category: state.category!,
      priority: state.priority!,
      dateTime: state.dateTime!,
      description: state.description,
    );
    await ref.read(taskViewModelProvider.notifier).addTask(task);
    return task;
  }
}
