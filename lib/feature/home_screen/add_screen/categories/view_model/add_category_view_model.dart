import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/icon_picker_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

final addCategoryProvider =
    StateNotifierProvider<AddCategoryNotifier, AddCategoryState>(
      (ref) => AddCategoryNotifier(ref),
    );

class AddCategoryState {
  String name;
  IconPickerIcon? selectedIcon;
  Color? selectedColor;

  AddCategoryState({this.name = '', this.selectedIcon, this.selectedColor});

  AddCategoryState copyWith({
    String? name,
    IconPickerIcon? selectedIcon,
    Color? selectedColor,
  }) {
    return AddCategoryState(
      name: name ?? this.name,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}

class AddCategoryNotifier extends StateNotifier<AddCategoryState> {
  final Ref ref;

  AddCategoryNotifier(this.ref) : super(AddCategoryState());

  void addTitle(String title) => state = state.copyWith(name: title);

  void addColor(Color color) => state = state.copyWith(selectedColor: color);

  void addIcon(IconPickerIcon icon) =>
      state = state.copyWith(selectedIcon: icon);

  Future<Category?> addCategory(BuildContext context) async {
    if (state.name.trim().isEmpty ||
        state.selectedColor == null ||
        state.selectedIcon == null) {
      return null;
    }
    final category = Category(
      name: state.name.trim(),
      color: state.selectedColor!,
      icon: state.selectedIcon!.data,
    );
    await ref.read(categoryViewModelProvider.notifier).addCategory(category);
    return category;
  }
}
