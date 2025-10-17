import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTitleItem extends StatelessWidget {
  EditTitleItem({
    super.key,
    required this.descriptionController,
    required this.titleController,
    required this.editButton,
  });

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  VoidCallback editButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 327,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xff363636),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(
              "Edit Task Title",
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8875FF),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: editButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8875FF),
                      foregroundColor: Color(0xff8875FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      "Edit Task",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
