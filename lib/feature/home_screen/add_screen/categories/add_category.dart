import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/notification/notification_bar.dart';
import 'package:up_todo_app/core/reusable_widgets/custom_text_field.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/categories/view_model/add_category_view_model.dart';
import 'package:up_todo_app/feature/home_screen/add_screen/categories/widget/category_color.dart';

import '../../index/data/model/task_model.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  AddCategoryScreen({super.key, this.selectedCategory});
  Category? selectedCategory;
  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategoryScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addCategoryProvider);
    final notifier = ref.read(addCategoryProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: <Widget>[
                  Text(
                    "Create new category",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xe0ffffff),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Category name :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xe0ffffff),
                    ),
                  ),
                  CustomTextField(
                    onChange: notifier.addTitle,
                    hint: "Category name",
                    textController: nameController,
                  ),
                  Text(
                    "Category icon :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xe0ffffff),
                    ),
                  ),
                  SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: _pickIcon,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff202020),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: state.selectedIcon == null
                        ? Text(
                            "Choose icon from library",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xe0ffffff),
                            ),
                          )
                        : Icon(
                            state.selectedIcon!.data,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                  Text(
                    "Category color :",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xe0ffffff),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final currentColor = colors[index];
                        return InkWell(
                          onTap: () {
                            notifier.addColor(currentColor);
                          },
                          child: CategoryColor(
                            color: colors[index],
                            isSelectedColor:
                                state.selectedColor == currentColor,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                      itemCount: colors.length,
                    ),
                  ),
                  //Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xe0ffffff),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await notifier.addCategory(context);
                              Navigator.pop(context);
                            } catch (e) {
                              NotificationBar.showNotification(
                                message: "Please Fill All Fields",
                                type: ContentType.failure,
                                context: context,
                                icon: Icons.error,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            backgroundColor: Color(0xff8875FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            "Create Category",
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xe0ffffff),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Color> colors = [
    Color(0xffC9CC41),
    Color(0xff66CC41),
    Color(0xff41CCA7),
    Color(0xff4181CC),
    Color(0xff41A2CC),
    Color(0xffCC8441),
    Color(0xff9741CC),
    Color(0xffCC4173),
    Color(0xff18148a),
    Color(0xff603b3b),
  ];

  Future<void> _pickIcon() async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconSize: 30,
        showTooltips: true,
        backgroundColor: Colors.black12,
        title: Text(
          "Choose Icon",
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xe0ffffff),
          ),
        ),
        adaptiveDialog: true,
        iconPackModes: [
          IconPack.material,
          IconPack.cupertino,
          IconPack.fontAwesomeIcons,
        ],
        searchComparator: (String search, IconPickerIcon icon) =>
            search.toLowerCase().contains(
              icon.name.replaceAll('_', ' ').toLowerCase(),
            ) ||
            icon.name.toLowerCase().contains(search.toLowerCase()),
        iconPickerShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        iconColor: Colors.white,
      ),
    );
    if (icon != null) {
      ref.read(addCategoryProvider.notifier).addIcon(icon);
    }
  }
}
