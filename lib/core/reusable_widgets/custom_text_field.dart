import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../feature/home_screen/person/setteings/fonts/provider/font_provider.dart';

class CustomTextField extends ConsumerWidget {
  final Function(String) onChange;
  final String hint;

  const CustomTextField({
    super.key,
    required this.onChange,
    required this.hint,
    required this.textController,
  });
  final TextEditingController textController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);

    return TextField(
      controller: textController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.getFont(
          selectedFont,
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
      onChanged: onChange,
    );
  }
}
