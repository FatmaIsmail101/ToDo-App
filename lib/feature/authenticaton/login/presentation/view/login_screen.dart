import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_todo_app/feature/authenticaton/local_auth/local_auth.dart';
import 'package:up_todo_app/feature/authenticaton/login/presentation/view_model/login_with_facebook_provider.dart';

import '../../../../../core/notification/notification_bar.dart';
import '../../../../../core/reusable_widgets/buttons.dart';
import '../../../../../core/reusable_widgets/text_form_field.dart';
import '../providers/auth_providers.dart';
import '../view_model/login_state.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);

    // 🎯 نسمع للتغييرات في الـ state
    ref.listen<LoginState>(loginViewModelProvider, (prev, next) {
      // ⚠ Error
      if (next.state == LoginStatus.error) {
        NotificationBar.showNotification(
          message: next.error ?? "Something went wrong",
          type: ContentType.failure,
          context: context,
          icon: Icons.error,
        );
      }

      // ✅ Success / needLocalAuth
      if (next.state == LoginStatus.needLocalAuth && next.model != null) {
        showModalBottomSheet(
          context: context,
          builder: (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.fingerprint),
                title: Text(
                  'Please hold your finger at the fingerprint scanner to verify your identity',
                ),
                onTap: () async {
                  bool success = await LocalAuthHelper.authenticate();
                  if (success) {
                    NotificationBar.showNotification(
                      message: "Authenticated with Fingerprint",
                      type: ContentType.success,
                      context: context,
                      icon: Icons.check,
                    );
                    Navigator.pop(context);
                  } else {
                    NotificationBar.showNotification(
                      message: "Fingerprint authentication failed",
                      type: ContentType.failure,
                      context: context,
                      icon: Icons.error,
                    );
                  }
                  // هنا تحطي كود الـ Local Auth
                },
              ),
              ListTile(
                leading: Icon(Icons.pin),
                title: Text('Login with PIN'),
                onTap: () {
                  // هنا تحطي كود الـ PIN Auth
                  Navigator.pop(context);
                  final pinController = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Enter PIN"),
                      content: TextField(
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        decoration: InputDecoration(hintText: "PIN"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (pinController.text ==
                                LocalAuthHelper.getPin()) {
                              Navigator.pop(context);
                              NotificationBar.showNotification(
                                message: "Authenticated with PIN",
                                type: ContentType.success,
                                context: context,
                                icon: Icons.check,
                              );
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              NotificationBar.showNotification(
                                message: "Incorrect PIN",
                                type: ContentType.failure,
                                context: context,
                                icon: Icons.error,
                              );
                            }
                          },
                          child: Text("Submit"),
                        ),
                      ],
                    ),
                  );
                  NotificationBar.showNotification(
                    message: "Authenticated with PIN",
                    type: ContentType.success,
                    context: context,
                    icon: Icons.check,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.88),
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
                    Button(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(loginViewModelProvider.notifier)
                              .login(
                                nameController.text,
                                passwordController.text,
                              );
                        }
                      },
                      text: "Login",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.88),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Divider(color: Color(0xff979797)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff979797),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Divider(color: Color(0xff979797)),
                        ),
                      ],
                    ),

                    Button(
                      isColor: false,
                      onPressed: () {},
                      text: "Login With Google",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0xe0ffffff),
                      ),
                    ),
                    Button(
                      isColor: false,
                      onPressed: () async {
                        final userDate =
                            await FacebookLoginService.signInWithFacebook();
                        if (userDate != null) {
                          print("User Info :$userDate");
                        } else {
                          print("Login failed");
                        }
                      },
                      text: "Login With Facebook",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color(0xe0ffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔄 Loading
            if (loginState.state == LoginStatus.loading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
