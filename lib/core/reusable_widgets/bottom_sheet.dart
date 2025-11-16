import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config/size_config.dart';

class BottomSheetItem {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  BottomSheetItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });
}

class CustomBottomSheet {
  static void show({
    required BuildContext context,
    required String title,
    required List<BottomSheetItem> items,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(SizeConfig.heightRatio(20))),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(SizeConfig.widthRatio(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: SizeConfig.widthRatio(18),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: SizeConfig.heightRatio(16).toInt()),
              ...items.map(
                (item) => ListTile(
                  leading: Icon(item.icon, color: Colors.white),
                  title: Text(
                    item.text,
                    style: GoogleFonts.lato(color: Colors.white),
                  ),
                  onTap: item.onTap, // ✳ دي أهم حاجة
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
