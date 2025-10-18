import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/widget/category_item.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../index/presentation/task_provider/task_providers.dart';
import 'categories/add_category.dart';

class CategoryDialog extends ConsumerStatefulWidget {
  CategoryDialog({super.key, this.selectedCategory});

  Category? selectedCategory;

  @override
  ConsumerState<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends ConsumerState<CategoryDialog> {
  @override
  Widget build(BuildContext context) {
    // 🧠 هنا هنقرأ الكاتيجوريز من الـ provider
    final categories = ref.watch(categoryViewModelProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(
              "Choose Category",
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(color: Colors.white),

            // 🧩 عرض الكاتيجوريز من الـ provider بدلاً من الليست الثابتة
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 2,
                  childAspectRatio: .8,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return CategoryItem(
                    model: category,
                    isSelected: widget.selectedCategory == category,
                    selected: () async {
                      // ✅ لو آخر عنصر = "Create New"
                      if (index == categories.length - 1) {
                        final newCategory = await Navigator.push<Category>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCategoryScreen(),
                          ),
                        );

                        if (newCategory != null && context.mounted) {
                          setState(() {
                            categories.insert(
                                categories.length - 1, newCategory);
                            widget.selectedCategory = newCategory;
                          });
                        }
                      } else {
                        setState(() {
                          widget.selectedCategory = category;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                if (widget.selectedCategory != null) {
                  Navigator.pop(context, widget.selectedCategory);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                "Add Category",
                style: GoogleFonts.lato(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}