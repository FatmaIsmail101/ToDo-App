import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/category_dialog.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/priority_dialog.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/presentation/task_provider/task_providers.dart';

import '../../../../../core/assets/assets.dart';
import '../../../add_screen/widget/edit_title_item.dart';

class EditSecreen extends ConsumerStatefulWidget {
  EditSecreen({super.key});

  @override
  @override
  ConsumerState<EditSecreen> createState() => _EditSecreenState();
}

class _EditSecreenState extends ConsumerState<EditSecreen> {
  DateTime? selectedDateTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Category? selectedCategory;
  TaskPriority? selectedPriority;
  bool isComplete = false;

  Widget build(BuildContext context) {
    final taskState = ref.watch(taskViewModelProvider);
    final model = ModalRoute.of(context)!.settings.arguments as TaskModel;
    final editedModel = TaskModel(
      id: model.id,
      title: titleController.text.trim().isEmpty
          ? model.title
          : titleController.text.trim(),
      isComplete: isComplete ? model.isComplete : isComplete,
      category: selectedCategory ?? model.category,
      priority: selectedPriority ?? model.priority,
      dateTime: selectedDateTime ?? model.dateTime,
      description: descriptionController.text.trim().isEmpty
          ? model.description
          : descriptionController.text.trim(),
    );
    print("Received model${model.title}");
    return Scaffold(
      backgroundColor: Color(0xff1D1D1D),
      appBar: AppBar(
        title: Text(
          "Edit Task ${model.title}",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1D1D1D),
        leading: Bounceable(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close, color: Colors.white),
        ),
        actions: [
          ImageIcon(AssetImage(Assets.leadingIcon), color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 40,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.isComplete
                      ? Icon(Icons.circle, color: Color(0xff8875FF))
                      : Icon(Icons.circle_outlined, color: Colors.white),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: GoogleFonts.lato(
                          color: Color(0xe0ffffff),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        model.description,
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Bounceable(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: EditTitleItem(
                              descriptionController: descriptionController,
                              titleController: titleController,
                              editButton: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: EditTitleItem(
                                        descriptionController:
                                            descriptionController,
                                        titleController: titleController,
                                        editButton: () {
                                          // هنا نحدث التاسك
                                          final editedTask = TaskModel(
                                            id: model.id,
                                            title:
                                                titleController.text
                                                    .trim()
                                                    .isEmpty
                                                ? model.title
                                                : titleController.text.trim(),
                                            isComplete: isComplete
                                                ? model.isComplete
                                                : isComplete,
                                            category:
                                                selectedCategory ??
                                                model.category,
                                            priority:
                                                selectedPriority ??
                                                model.priority,
                                            dateTime:
                                                selectedDateTime ??
                                                model.dateTime,
                                            description:
                                                descriptionController.text
                                                    .trim()
                                                    .isEmpty
                                                ? model.description
                                                : descriptionController.text
                                                      .trim(),
                                          );

                                          ref
                                              .read(
                                                taskViewModelProvider.notifier,
                                              )
                                              .editTask(editedTask);

                                          Navigator.pop(
                                            context,
                                          ); // يقفل الـ dialog
                                          Navigator.pop(
                                            context,
                                          ); // يرجع للـ IndexScreen
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.edit_note_sharp, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Task Time :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      pickDateTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.black12,
                    ),
                    child: selectedDateTime == null
                        ? Text(
                            DateFormat(
                              'dd/MM/yyyy hh:mm a',
                            ).format(model.dateTime),
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            DateFormat(
                              'dd/MM/yyyy hh:mm a',
                            ).format(selectedDateTime!),
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(Assets.tag),
                  SizedBox(width: 8),
                  Text(
                    "Task Category :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedCategoryItem = await showDialog<Category>(
                        context: context,

                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: CategoryDialog(
                              selectedCateogery: selectedCategory,
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        selectedCategory == null
                            ? Icon(model.category.icon, color: Colors.white)
                            : Icon(
                                editedTask.category.icon,
                                color: Colors.white,
                              ),
                        SizedBox(width: 6),
                        selectedCategory == null
                            ? Text(
                                "${model.category.name}",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                editedTask.category.name,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.flag),
                  SizedBox(width: 8),
                  Text(
                    "Task Priority :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedPriorityItem = await showDialog<TaskPriority>(
                        context: context,

                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        Icon(model.priority.label, color: Colors.white),
                        SizedBox(width: 6),
                        selectedPriority == null
                            ? Text(
                                "${model.priority.level}",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "${editedTask.priority.level}",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.task_rounded),
                  SizedBox(width: 8),
                  Text(
                    "Sub-Task  :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PageRouteName.addScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      backgroundColor: Colors.black12,
                    ),
                    child: Text(
                      "Add Sub-Task",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(taskViewModelProvider.notifier).removeTask(model.id);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    Text(
                      "Delete Task",
                      style: GoogleFonts.lato(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(taskViewModelProvider.notifier)
                      .editTask(editedModel);
                  Navigator.pop(context);
                },
                child: Text(
                  "Edit Task",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                  backgroundColor: Color(0xff8875FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 360)),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      barrierColor: Colors.black12,
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

  late final editedTask = TaskModel(
    title: titleController.text.trim() ?? "",
    isComplete: isComplete,
    category:
        selectedCategory ??
        Category(
          name: "Health",
          color: Colors.red,
          icon: Icons.health_and_safety,
        ),
    priority: selectedPriority ?? TaskPriority(level: 1, label: Icons.flag),
    dateTime: selectedDateTime ?? DateTime(2025),
    description: descriptionController.text.trim() ?? "",
  );
}
