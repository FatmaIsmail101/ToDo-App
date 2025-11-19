import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/core/notification/notification_bar.dart';
import 'package:up_todo_app/core/reusable_widgets/bottom_sheet.dart'
    show BottomSheetItem, CustomBottomSheet;
import 'package:up_todo_app/feature/authenticaton/register/presentation/providers/register_provider.dart';

import '../../../../../core/reusable_widgets/buttons.dart';
import '../../../../../core/reusable_widgets/text_form_field.dart';
import '../../../../../core/size_config/size_config.dart';
import '../../../local_auth/local_auth.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // void dispose() {
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   nameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerViewModelProvider);

    // 🎯 نسمع للتغييرات في الـ state
    ref.listen<AsyncValue<void>>(registerViewModelProvider, (prev, next) async {
      next.whenOrNull(
        error: (error, stackTrace) {
          return NotificationBar.showNotification(
            message: "Password dosen't match",
            type: ContentType.failure,
            context: context,
            icon: Icons.close,
          );
        },
        data: (user) {
          return NotificationBar.showNotification(
            message: "Congratulations! You Registered Successfully",
            type: ContentType.success,
            context: context,
            icon: Icons.add,
          );
        },
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,

      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Bounceable(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: SizeConfig.widthRatio(15),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.widthRatio(24)),
        //todo
        child: Stack(
          children: [
            // 🧩 الـ form الأساسية
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  spacing: SizeConfig.heightRatio(32),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Register",
                      style: GoogleFonts.lato(
                        fontSize: SizeConfig.widthRatio(32),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xe0ffffff),
                      ),
                    ),
                    Column(
                      spacing: SizeConfig.heightRatio(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: GoogleFonts.lato(
                            fontSize: SizeConfig.widthRatio(16),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xe0ffffff),
                          ),
                        ),
                        TextFormFieldWidget(
                          text: "User Name",
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your username";
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      spacing: SizeConfig.heightRatio(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.lato(
                            fontSize: SizeConfig.widthRatio(16),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xe0ffffff),
                          ),
                        ),
                        TextFormFieldWidget(
                          text: "Password",
                          controller: passwordController,
                          isObsecure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    Column(
                      spacing: SizeConfig.heightRatio(8),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Confirm Password",
                          style: GoogleFonts.lato(
                            fontSize: SizeConfig.widthRatio(16),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xe0ffffff),
                          ),
                        ),
                        TextFormFieldWidget(
                          text: "Confirm Password",
                          controller: confirmPasswordController,
                          isObsecure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                    Button(
                      text: "Register",
                      style: GoogleFonts.lato(
                        fontSize: SizeConfig.widthRatio(16),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // ✅ بعد ما المستخدم يكتب البيانات بشكل صحيح
                          CustomBottomSheet.show(
                            context: context,
                            title: "Enable Local Authentication",
                            items: [
                              // 🟢 Fingerprint
                              BottomSheetItem(
                                icon: Icons.fingerprint,
                                text: "Enable Fingerprint",
                                onTap: () async {
                                  Navigator.pop(context);
                                  bool success =
                                      await LocalAuthHelper.authenticate();
                                  if (success) {
                                    await LocalAuthHelper.enabledBiometric();

                                    await ref
                                        .read(
                                          registerViewModelProvider.notifier,
                                        )
                                        .register(
                                          nameController.text,
                                          passwordController.text,
                                          confirmPasswordController.text,
                                        );

                                    NotificationBar.showNotification(
                                      message:
                                          "Fingerprint login enabled successfully",
                                      type: ContentType.success,
                                      context: context,
                                      icon: Icons.check,
                                    );
                                  } else {
                                    NotificationBar.showNotification(
                                      message: "Fingerprint setup failed",
                                      type: ContentType.failure,
                                      context: context,
                                      icon: Icons.error,
                                    );
                                  }
                                },
                              ),

                              // 🟡 Set PIN
                              BottomSheetItem(
                                icon: Icons.pin,
                                text: "Set PIN",
                                onTap: () {
                                  Navigator.pop(context);

                                  final pinController = TextEditingController();

                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Set PIN"),
                                      content: SizedBox(
                                        width: SizeConfig.widthRatio(80),
                                        height: SizeConfig.heightRatio(20),
                                        child: TextField(
                                          controller: pinController,
                                          keyboardType: TextInputType.number,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Enter your PIN (e.g. 1234)",
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            if (pinController.text.isEmpty) {
                                              return;
                                            }

                                            // 🔹 نحفظ الـ PIN في SharedPreferences
                                            await LocalAuthHelper.setPin(
                                              pinController.text,
                                            );

                                            // 🔹 نسجّل المستخدم بعد ما يدخل الـ PIN
                                            await ref
                                                .read(
                                                  registerViewModelProvider
                                                      .notifier,
                                                )
                                                .register(
                                                  nameController.text,
                                                  passwordController.text,
                                                  confirmPasswordController
                                                      .text,
                                                );

                                            Navigator.pop(context);

                                            // 🔹 إشعار بالنجاح
                                            NotificationBar.showNotification(
                                              message: "PIN saved successfully",
                                              type: ContentType.success,
                                              context: context,
                                              icon: Icons.check,
                                            );
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              // 🔴 Skip
                              BottomSheetItem(
                                icon: Icons.cancel,
                                text: "Skip for now",
                                onTap: () async {
                                  Navigator.pop(context);

                                  await ref
                                      .read(registerViewModelProvider.notifier)
                                      .register(
                                        nameController.text,
                                        passwordController.text,
                                        confirmPasswordController.text,
                                      );

                                  NotificationBar.showNotification(
                                    message:
                                        "Registered successfully (without local auth)",
                                    type: ContentType.success,
                                    context: context,
                                    icon: Icons.check,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Divider(color: Color(0xff979797)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthRatio(10),
                          ),
                          child: Text(
                            "Or",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.widthRatio(16),
                              color: Color(0xff979797),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Divider(color: const Color(0xff979797)),
                        ),
                      ],
                    ),

                    Button(
                      isColor: false,
                      onPressed: () {},
                      text: "Login With Google",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.widthRatio(16),
                        color: const Color(0xe0ffffff),
                      ),
                    ),
                    Button(
                      isColor: false,
                      onPressed: () {},
                      text: "Login With Apple",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.widthRatio(16),
                        color: const Color(0xe0ffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔄 حالة الـ loading فوق الصفحة
            if (registerState.isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
