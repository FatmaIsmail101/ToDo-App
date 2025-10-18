import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/category_dialog.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/priority_dialog.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

import '../../../core/assets/assets.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDateTime;
  Category? selectedCategory;
  TaskPriority? selectedPriority;
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
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

              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              TextField(
                controller: descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // 🟣 اختيار الكاتيجوري

              // ⏰ زرار التاريخ والساعة
              Row(
                children: [
                  IconButton(
                    onPressed: () => pickDate(context),
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
                              selectedCategory: selectedCategory,
                            ),
                          );
                        },
                      );
                      if (selectedCategoryItem != null) {
                        setState(() {
                          selectedCategory = selectedCategoryItem;
                        });
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
                                  selectedPriorty: selectedPriority,
                                ),
                              );
                            },
                          );
                      if (selectedPriorityItem != null) {
                        setState(() {
                          selectedPriority = selectedPriorityItem;
                        });
                      }
                    },
                    child: Icon(Icons.flag, color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: addTask,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDate(BuildContext context) async {
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

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty ||
        selectedCategory == null ||
        selectedPriority == null ||
        selectedDateTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    final task = TaskModel(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      isComplete: isComplete,
      category: selectedCategory!,
      priority: selectedPriority!,
      dateTime: selectedDateTime!,
    );

    await ref.read(taskViewModelProvider.notifier).addTask(task);
    Navigator.pop(context);
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
