import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/extenssion/extenssion.dart';
import 'package:up_todo_app/core/notification/notification_bar.dart';
import 'package:up_todo_app/core/reusable_widgets/buttons.dart';
import 'package:up_todo_app/core/routes/page_route_name.dart';
import 'package:up_todo_app/feature/home_screen/person/image/provider.dart';
import 'package:up_todo_app/feature/home_screen/person/log_out/provider/providers.dart';
import 'package:up_todo_app/feature/home_screen/person/presentation/view/widget/card_number_of_tasks.dart';

import '../../../../../core/assets/assets.dart';
import '../../../../../core/size_config/size_config.dart';
import '../../../../authenticaton/login/presentation/providers/auth_providers.dart';
import '../../../index/presentation/task_provider/task_providers.dart';
import '../../setteings/fonts/provider/font_provider.dart';
import '../../setteings/theme/provider.dart';
import '../../update/view_model/providers.dart';

class PersonScreen extends ConsumerWidget {
  PersonScreen({super.key});

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    final update = ref.watch(updateProvider);
    final notifier = ref.read(updateProvider.notifier);
    final loginState = ref.watch(loginViewModelProvider);
    final taskState = ref.watch(taskViewModelProvider);
    final complete = taskState
        .where((element) => element.isComplete == true)
        .toList();
    final notComplete = taskState
        .where((element) => element.isComplete == false)
        .toList();
    final logOut = ref.watch(logOutProvider);
    final selectedFont = ref.watch(fontProvider);
    final safeFont = (selectedFont.isEmpty) ? "Lato"
        : selectedFont;

    final imagePath = ref.watch(pickImage);
    final imageNotifier = ref.watch(pickImage.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: currentColor.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: currentColor.colorScheme.primary,
        centerTitle: true,
        title: Text(
          context.local?.profile ?? "",
          style: GoogleFonts.getFont(
            safeFont,
            fontSize: SizeConfig.widthRatio(20),
            fontWeight: FontWeight.normal,
            color: Color(0xe0ffffff),
          ),
        ),
        leading: SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: SizeConfig.heightRatio(20),
            children: [
              //Image
              Center(
                child: CircleAvatar(
                  backgroundImage: imagePath != null && imagePath.isNotEmpty
                      ? FileImage(
                      File(imagePath,), scale: SizeConfig.widthRatio(25))
                      : null,
                  foregroundImage: imagePath != null && imagePath.isNotEmpty
                      ? FileImage(File(imagePath))
                      : null,
                  radius: SizeConfig.widthRatio(86),
                  child: imagePath == null || imagePath.isEmpty
                      ? Icon(Icons.person, size: SizeConfig.widthRatio(70),
                      color: Colors.white)
                      : null,
                ),
              ),
              Center(
                child: Text(
                  loginState.model?.name.toUpperCase() ?? "Null",
                  style: GoogleFonts.getFont(
                    safeFont,
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.widthRatio(16),
                    color: Colors.white,
                  ),
                ),
              ),
              //Number of Tasks
              Row(
                spacing: SizeConfig.widthRatio(20),
                children: <Widget>[
                  CardNumberOfTasks(number: notComplete.length, word: "left"),
                  CardNumberOfTasks(number: complete.length, word: "done"),
                ],
              ),
              Text(
                context.local?.settings ?? "",
                style: GoogleFonts.getFont(
                  safeFont,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.widthRatio(14),
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageRouteName.appSettings);
                },
                child: Row(
                  spacing: SizeConfig.widthRatio(10),
                  children: <Widget>[
                    Icon(Icons.settings, color: Colors.white,
                        size: SizeConfig.widthRatio(15)),
                    Text(
                      context.local?.app_settings ?? "",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(16),
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: SizeConfig.widthRatio(15),
                    ),
                  ],
                ),
              ),
              Text(
                context.local?.account ?? "",
                style: GoogleFonts.getFont(
                  safeFont,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.widthRatio(14),
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog<String>(
                    context: context,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {
                      return alertDialog(
                        context: context,
                        text: context.local?.change_account_name ?? "",
                        controller: nameController,
                        hint: "Enter Name",
                        onTap: () async {
                          notifier.updateName(nameController.text);
                          final updatedUserName = await ref
                              .read(loginViewModelProvider.notifier)
                              .login(
                                nameController.text,
                                loginState.model?.password ?? "",
                              );
                          Navigator.pop(context);
                          NotificationBar.showNotification(
                            message: "Mabrook",
                            type: ContentType.success,
                            context: context,
                            icon: Icons.access_time,
                          );
                        },
                      );
                    },
                  );
                },
                child: Row(
                  spacing: SizeConfig.widthRatio(10),
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.white,
                        size: SizeConfig.widthRatio(15)),
                    Text(
                      context.local?.change_account_name ?? "",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(16),
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: SizeConfig.widthRatio(15),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {
                      return alertDialog(
                        hint: "Change Password",
                        controller: passwordController,
                        text: "Change account Password",
                        context: context,
                        onTap: () async {
                          notifier.updatePassword(passwordController.text);
                          final updatedUserPassword = ref
                              .read(loginViewModelProvider.notifier)
                              .login(
                                loginState.model?.name ?? "",
                                passwordController.text,
                              );
                          Navigator.pop(context);
                          NotificationBar.showNotification(
                            message: "Mabrook",
                            type: ContentType.success,
                            context: context,
                            icon: Icons.access_time,
                          );
                        },
                      );
                    },
                  );
                },
                child: Row(
                  spacing: SizeConfig.widthRatio(10),
                  children: <Widget>[
                    Icon(
                      Icons.lock_outline_sharp,
                      color: Colors.white,
                      size: SizeConfig.widthRatio(15),
                    ),
                    Expanded(
                      child: Text(
                        context.local?.change_account_password ?? "",
                        style: GoogleFonts.getFont(
                          safeFont,
                          fontWeight: FontWeight.normal,
                          fontSize: SizeConfig.widthRatio(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //  Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: SizeConfig.widthRatio(15),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await showBottomSheet(context, ref);
                },
                child: Row(
                  spacing: SizeConfig.widthRatio(10),
                  children: <Widget>[
                    Icon(Icons.image_rounded, color: Colors.white,
                        size: SizeConfig.widthRatio(15)),
                    Text(
                      context.local?.change_account_image ?? "",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(16),
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: SizeConfig.widthRatio(15),
                    ),
                  ],
                ),
              ),
              Text(
                "Uptodo",
                style: GoogleFonts.getFont(
                  safeFont,
                  fontWeight: FontWeight.normal,
                  fontSize: SizeConfig.widthRatio(14),
                  color: Colors.grey,
                ),
              ),
              Row(
                spacing: SizeConfig.widthRatio(10),
                children: <Widget>[
                  Image.asset(Assets.about, color: Colors.white),
                  Text(
                    context.local?.about_us ?? "",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.widthRatio(16),
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: SizeConfig.widthRatio(15),
                  ),
                ],
              ),
              Row(
                spacing: SizeConfig.widthRatio(10),
                children: <Widget>[
                  // Icon(Icons.info_outline,color: Colors.white,size: 30,)
                  Image.asset(Assets.help, color: Colors.white),
                  Text(
                    "FAQ",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.widthRatio(16),
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: SizeConfig.widthRatio(15),
                  ),
                ],
              ),
              Row(
                spacing: SizeConfig.widthRatio(10),
                children: <Widget>[
                  Image.asset(Assets.like, color: Colors.white),
                  Text(
                    context.local?.support_us ?? "",
                    style: GoogleFonts.getFont(
                      safeFont,
                      fontWeight: FontWeight.normal,
                      fontSize: SizeConfig.widthRatio(16),
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: SizeConfig.widthRatio(15),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  await ref.read(logOutProvider.notifier).removeAccount();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    PageRouteName.registerScreen,
                    (route) => false,
                  );
                  NotificationBar.showNotification(
                    message: "Removed Successfully ",
                    type: ContentType.success,
                    context: context,
                    icon: Icons.remember_me,
                  );
                },
                child: Row(
                  spacing: SizeConfig.widthRatio(10),
                  children: <Widget>[
                    Icon(Icons.logout, color: Colors.red,
                        size: SizeConfig.widthRatio(15)),
                    // Image.asset(Assets.like,color: Colors.white,),
                    Text(
                      context.local?.log_out ?? "",
                      style: GoogleFonts.getFont(
                        safeFont,
                        fontWeight: FontWeight.normal,
                        fontSize: SizeConfig.widthRatio(16),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog alertDialog({
    required BuildContext context,
    required String text,
    required VoidCallback onTap,
    required TextEditingController controller,
    required String hint,
  }) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        Button(
          onPressed: onTap,
          text: 'Edit',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.normal,
            fontSize: SizeConfig.widthRatio(16),
            color: Colors.white,
          ),
        ),
      ],

      backgroundColor: Colors.black,
      title: Text(
        text,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.normal,
          fontSize: SizeConfig.widthRatio(16),
          color: Colors.white,
        ),
      ),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.lato(
            fontSize: SizeConfig.widthRatio(16),
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.white,
            size: SizeConfig.widthRatio(16),),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(SizeConfig.widthRatio(4)),
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.black,
          focusColor: Colors.white,
        ),
        style: GoogleFonts.lato(
          fontSize: SizeConfig.widthRatio(16),
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context, WidgetRef ref) async {
    final imageNotifier = ref.watch(pickImage.notifier);
    final selectedColor = ref.watch(themeSchemeProvider);
    final themePreview = FlexThemeData.light(scheme: selectedColor);
    final darkThemePreview = FlexThemeData.dark(scheme: selectedColor);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentColor = isDark ? darkThemePreview : themePreview;
    return await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.widthRatio(12))),
      sheetAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
      backgroundColor: currentColor.colorScheme.primary,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
          child: Column(
            spacing: SizeConfig.heightRatio(12),
            children: [
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  "Change account Image",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.widthRatio(16),
                    color: Colors.red,
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                height: SizeConfig.heightRatio(20),
                indent: SizeConfig.widthRatio(32),
                endIndent: SizeConfig.widthRatio(32),
              ),
              GestureDetector(
                onTap: () {
                  imageNotifier.setImage(fromCamera: true);
                },
                child: Text(
                  "Take picture",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.widthRatio(16),
                    color: Colors.red,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  imageNotifier.setImage();
                },
                child: Text(
                  "Import from gallery",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.widthRatio(16),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
