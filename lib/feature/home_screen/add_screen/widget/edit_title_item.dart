import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/size_config/size_config.dart';
import '../../person/setteings/fonts/provider/font_provider.dart';

class EditTitleItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;

    return Container(
      height: SizeConfig.heightRatio(300),
      width: SizeConfig.widthRatio(328),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
        color: Color(0xff363636),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.widthRatio(10)),
        child: Column(
          spacing: SizeConfig.heightRatio(16),
          children: [
            Text(
              "Edit Task Title",
              style: GoogleFonts.getFont(
                safeFont,
                color: Colors.white,
                fontSize: SizeConfig.widthRatio(22),
                fontWeight: FontWeight.w600,
              ),
            ),

            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: GoogleFonts.getFont(
                  safeFont,
                  color: Colors.white,
                  fontSize: SizeConfig.widthRatio(22),
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(
                      SizeConfig.widthRatio(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(
                      SizeConfig.widthRatio(12)),
                ),
              ),
            ),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: GoogleFonts.getFont(
                  safeFont,
                  color: Colors.white,
                  fontSize: SizeConfig.widthRatio(22),
                  fontWeight: FontWeight.w600,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.circular(
                      SizeConfig.widthRatio(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white54),
                  borderRadius: BorderRadius.circular(
                      SizeConfig.widthRatio(12)),
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
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontSize: SizeConfig.widthRatio(16),
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
                        borderRadius: BorderRadius.circular(
                            SizeConfig.widthRatio(4)),
                      ),
                    ),
                    child: Text(
                      "Edit Task",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.widthRatio(16),
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
