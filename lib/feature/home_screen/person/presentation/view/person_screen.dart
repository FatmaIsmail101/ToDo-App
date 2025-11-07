import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/reusable_widgets/buttons.dart';
import 'package:up_todo_app/feature/home_screen/person/name/view_model/provider.dart';
import 'package:up_todo_app/feature/home_screen/person/presentation/view/widget/card_number_of_tasks.dart';

import '../../../../../core/assets/assets.dart';
import '../../../../authenticaton/login/presentation/providers/auth_providers.dart';
import '../../../index/presentation/task_provider/task_providers.dart';

class PersonScreen extends ConsumerWidget {
  PersonScreen({super.key});

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Color(0xe0ffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              //Image
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(Assets.userImg),
                  foregroundImage: AssetImage(Assets.userImg),
                  radius: 86,
                ),
              ),
              Center(
                child: Text(
                  loginState.model?.name.toUpperCase() ?? "Null",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              //Number of Tasks
              Row(
                spacing: 20,
                children: <Widget>[
                  CardNumberOfTasks(number: notComplete.length, word: "left"),
                  CardNumberOfTasks(number: complete.length, word: "done"),
                ],
              ),
              Text(
                "Settings",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.settings, color: Colors.white, size: 35),
                  Text(
                    "App Settings",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Text(
                "Account",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {
                      return alertDialog(
                        context: context,
                        text: "Change account name",
                        controller: nameController,
                        hint: "Enter Name",
                        onTap: () {
                          notifier.updateName(nameController.text);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Row(
                  spacing: 10,
                  children: <Widget>[
                    Icon(Icons.person, color: Colors.white, size: 35),
                    Text(
                      "Change account name",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.lock_outline_sharp, color: Colors.white, size: 35),
                  Expanded(
                    child: Text(
                      "Change account password",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.image_rounded, color: Colors.white, size: 35),
                  Text(
                    "Change account Image",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Text(
                "Uptodo",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Image.asset(Assets.about, color: Colors.white),
                  Text(
                    "About US",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  // Icon(Icons.info_outline,color: Colors.white,size: 30,)
                  Image.asset(Assets.help, color: Colors.white),
                  Text(
                    "FAQ",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Image.asset(Assets.like, color: Colors.white),
                  Text(
                    "Support US",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: <Widget>[
                  Icon(Icons.logout, color: Colors.red, size: 30),
                  // Image.asset(Assets.like,color: Colors.white,),
                  Text(
                    "Log out",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
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
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],

      backgroundColor: Colors.black,
      title: Text(
        text,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.black,
          focusColor: Colors.white,
        ),
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}
