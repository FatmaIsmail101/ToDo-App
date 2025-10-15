import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/widget/category_item.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

class CategoryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Divider(color: Colors.white),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) =>
                    CategoryItem(model: categoryesList[index]),
                itemCount: categoryesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 2,
                  childAspectRatio: .8,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
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

  List<Category> categoryesList = [
    Category(
      name: "Grocery",
      color: Colors.lightGreenAccent,
      icon: Icons.local_grocery_store,
    ),
    Category(name: "Work", color: Colors.red, icon: Icons.work),
    Category(
      name: "Sport",
      color: Colors.greenAccent,
      icon: Icons.sports_baseball,
    ),
    Category(
      name: "Design",
      color: Colors.greenAccent,
      icon: Icons.design_services,
    ),
    Category(
      name: "University",
      color: Colors.blue.shade200,
      icon: Icons.cast_for_education,
    ),
    Category(
      name: "Social",
      color: Colors.pink.shade200,
      icon: Icons.social_distance,
    ),
    Category(
      name: "Music",
      color: Colors.pink.shade200,
      icon: Icons.music_note,
    ),
    Category(
      name: "Health",
      color: Colors.greenAccent.shade700,
      icon: Icons.health_and_safety,
    ),
    Category(name: "Movie", color: Colors.blue.shade100, icon: Icons.movie),
    Category(name: "Home", color: Color(0xffFFCC80), icon: Icons.home),
    Category(name: "Create New", color: Color(0xff80FFD1), icon: Icons.add),
  ];
}
