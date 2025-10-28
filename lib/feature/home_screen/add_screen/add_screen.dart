import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/notification/notification_bar.dart';
import 'package:up_todo_app/core/reusable_widgets/custom_text_field.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/category_dialog.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/priority_dialog.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/view_model/add_task_view_model.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../../../core/assets/assets.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskProvider);
    final notifier = ref.read(addTaskProvider.notifier);
    return Material(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Text(
                "Add Task",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              //title
              CustomTextField(
                onChange: notifier.updateTitle,
                hint: "Title",
                textController: titleController,
              ),
              //Description
              CustomTextField(
                textController: descriptionController,
                onChange: notifier.updateDescription,
                hint: "Description",
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => pickDate(context, notifier),
                    icon: const Icon(Icons.access_time, color: Colors.white),
                  ),

                  Bounceable(
                    onTap: () async {
                      final selectedCategoryItem = await showDialog<Category>(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: CategoryDialog(
                              selectedCategory: state.category,
                            ),
                          );
                        },
                      );
                      if (selectedCategoryItem != null) {
                        notifier.updateCategory(selectedCategoryItem);
                      }
                    },
                    child: Image.asset(Assets.tag),
                  ),
                  Bounceable(
                    onTap: () async {
                      final selectedPriorityItem =
                          await showDialog<TaskPriority>(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.black,
                                child: PriorityDialog(
                                  selectedPriorty: state.priority,
                                ),
                              );
                            },
                          );
                      if (selectedPriorityItem != null) {
                        notifier.updatePriority(selectedPriorityItem);
                      }
                    },
                    child: Icon(Icons.flag, color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: () async {
                      final task = await ref
                          .read(addTaskProvider.notifier)
                          .saveTask();
                      if (task != null) {
                        NotificationBar.showNotification(
                          message: "Task Added Successfully",
                          type: ContentType.success,
                          context: context,
                          icon: Icons.check,
                        );
                        Navigator.pop(context);
                      } else {
                        NotificationBar.showNotification(
                          message: "Fill All fields",
                          type: ContentType.failure,
                          context: context,
                          icon: Icons.error,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDate(BuildContext context, AddTaskNotifier notifier) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    notifier.updateDateTime(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }
}

/*
DropdownButtonFormField<Category>(
                dropdownColor: Colors.black87,
                initialValue: selectedCategory,
                items: [
                  Category(name: "Work", color: Colors.blue, icon: Icons.work),
                  Category(name: "Personal", color: Colors.pink, icon: Icons.person),
                  Category(name: "Study", color: Colors.green, icon: Icons.book),
                ].map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Row(
                      children: [
                        Icon(cat.icon, color: cat.color),
                        const SizedBox(width: 8),
                        Text(cat.name, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => selectedCategory = val);
                },
                decoration: const InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),


              // 🔴 اختيار الأولوية
              DropdownButtonFormField<TaskPriority>(
                dropdownColor: Colors.black87,
                initialValue: selectedPriority,
                items: [
                  TaskPriority(level: 1, label: Icons.flag),
                  TaskPriority(level: 2, label: Icons.flag_outlined),
                  TaskPriority(level: 3, label: Icons.flag_circle),
                ].map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Column(
                      children: [
                        Icon(priority.label, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          "Priority ${priority.level}",
                          style: const TextStyle(color: Colors.white),
                        ),

                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => selectedPriority = val);
                },
                decoration: const InputDecoration(
                  labelText: "Priority",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
 */
