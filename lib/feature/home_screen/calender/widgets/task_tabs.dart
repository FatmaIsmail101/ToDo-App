import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';

import '../../../../core/size_config/size_config.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class TaskTabs extends ConsumerWidget {
  const TaskTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(24)),
      padding: EdgeInsets.all(SizeConfig.widthRatio(6)),
      width: double.infinity,
      height: SizeConfig.heightRatio(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
        color: Color(0xff4C4C4C),
      ),
      child: Row(
        spacing: SizeConfig.widthRatio(32),
        children: [
          Expanded(
            child: _buildTabButton(
              context,
              ref,
              label: context.local?.not_completed ?? "",
              index: 0,
              isSelected: selectedTab == 0,
            ),
          ),
          Expanded(
            child: _buildTabButton(
              context,
              ref,
              label: context.local?.completed ?? "",
              index: 1,
              isSelected: selectedTab == 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return ElevatedButton(
      onPressed: () {
        ref.read(selectedTabProvider.notifier).state = index;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xff8685E7) : Colors.grey[800],
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthRatio(15),
            vertical: SizeConfig.heightRatio(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.white,
          ),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.lato(
          fontSize: SizeConfig.widthRatio(16),
          color: Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
