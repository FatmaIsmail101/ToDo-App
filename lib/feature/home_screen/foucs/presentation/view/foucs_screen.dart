import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/feature/home_screen/foucs/presentation/provider/timer_provider.dart';

import '../../../../../core/size_config/size_config.dart';
import '../../../person/setteings/fonts/provider/font_provider.dart';
import '../../../person/setteings/theme/provider.dart';

class FoucsScreen extends ConsumerWidget {
  const FoucsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerProvider);
    final notifier = ref.read(timerProvider.notifier);
    final remainingTime = state?.remainingTime ?? 0;
    final minutes = (remainingTime ~/ 60).toString().padLeft(2, "0");
    final secounds = (remainingTime % 60).toString().padLeft(2, "0");
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;

    return SafeArea(
      child: Scaffold(
        backgroundColor: currentColor.colorScheme.primary,
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
          child: Column(
            children: [
              Text(
                context.local?.focus_mode ?? "",
                style: GoogleFonts.getFont(
                  safeFont,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.widthRatio(20),
                  color: Color(0xe0ffffff),
                ),
              ),

              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: 0.0,
                        end: state == null || state.totalTime == 0
                            ? 0.0
                            : 1 - (remainingTime / state.totalTime),
                      ),
                      duration: const Duration(microseconds: 1),
                      builder: (context, value, _) {
                        final color = Color.lerp(
                          const Color(0xff8875FF),
                          Colors.white,
                          value,
                        )!;
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: color, width: SizeConfig.widthRatio(10)),
                          ),
                        );
                      },
                    ),
                    Text(
                      "$minutes:$secounds",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(30),
                        color: Color(0xe0ffffff),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  if (state == null || !state.isRunning) {
                    final picked = await pickTime(context);
                    if (picked != null) {
                      notifier.startTimer(picked["min"]!, picked["sec"]!);
                    }
                  } else {
                    notifier.stopTimer();
                  }
                },
                color: Color(0xff8875FF),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightRatio(12),
                    horizontal: SizeConfig.widthRatio(40)),
                focusColor: Color(0xff8875FF),
                child: Text(
                  (state == null || !state.isRunning)
                      ? context.local?.start_focusing ?? ""
                      : context.local?.stop_timer ?? "",
                  style: GoogleFonts.getFont(
                    safeFont,
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.widthRatio(20),
                    color: Color(0xe0ffffff),
                  ),
                ),
              ),
              if (state != null && !state.isRunning && state.remainingTime > 0)
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.heightRatio(16)),
                  child: MaterialButton(
                    onPressed: () async {
                      notifier.resumeTimer(state.remainingTime);
                    },
                    color: Color(0xff8875FF),
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.heightRatio(12)
                        , horizontal: SizeConfig.widthRatio(40)),
                    focusColor: Color(0xff8875FF),
                    child: Text(
                      context.local?.resume_timer ?? "",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(20),
                        color: Color(0xe0ffffff),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, int>?> pickTime(BuildContext context) async {
    int min = 0;
    int sec = 0;

    return showDialog<Map<String, int>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xff75caff),
              title: Text(
                context.local?.select_timer_duration ?? "",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.widthRatio(18),
                  color: Color(0xf5202020),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.local?.minutes ?? "",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig.widthRatio(18),
                          color: Color(0xf5202020),
                        ),
                      ),
                      DropdownButton<int>(
                        dropdownColor: Colors.blue[50],
                        value: min,
                        items: List.generate(
                          60,
                              (index) =>
                              DropdownMenuItem(
                                value: index,
                                child: Text(
                                  "$index",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeConfig.widthRatio(18),
                                    color: Color(0xf5202020),
                                  ),
                                ),
                              ),
                        ),
                        onChanged: (value) => setState(() => min = value ?? 0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.local?.seconds ?? "",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig.widthRatio(18),
                          color: Color(0xf5202020),
                        ),
                      ),
                      DropdownButton<int>(
                        dropdownColor: Colors.blue[50],
                        value: sec,
                        items: List.generate(
                          60,
                              (index) =>
                              DropdownMenuItem(
                                value: index,
                                child: Text(
                                  "$index",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeConfig.widthRatio(18),
                                    color: Color(0xf5202020),
                                  ),
                                ),
                              ),
                        ),
                        onChanged: (value) => setState(() => sec = value ?? 0),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(
                        context,
                      ).pop(<String, int>{"min": min, "sec": sec}),
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
