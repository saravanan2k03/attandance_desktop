// ignore_for_file: use_build_context_synchronously

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Data/Repository/core_repo.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Core/Utils/licensekey_diagloue.dart';
import 'package:act/Core/gen/assets.gen.dart';
import 'package:act/Features/Auth/Bloc/bloc/login_bloc.dart';
import 'package:act/Features/Auth/Presentation/Widgets/forogt_password_show_diaglue.dart';
import 'package:act/Features/Auth/Presentation/Widgets/my_textfield.dart';
import 'package:act/Features/Dashboard/Presentation/dashboard.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/new_leave_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final LoginBloc loginBloc = LoginBloc();
  FocusNode passwordfocus = FocusNode();
  void submit() async {
    final session = SessionManagerClass();
    final licenseKey = await session.getlicence();

    if (licenseKey.isEmpty) {
      toasterService.displayErrorMotionToast(
        context: context,
        content: Text("License key not found! Please enter a valid license."),
      );
      return;
    }

    try {
      final licenseRepo =
          LicenseRepo(); // make sure this is instantiated properly
      final status = await licenseRepo.checkLicenseStatus(licenseKey);

      if (!status.activated) {
        toasterService.displayErrorMotionToast(
          context: context,
          content: Text(
            "License key is not activated or expired. Please contact admin.",
          ),
        );
        return;
      }
      if (userNameTextController.text.trim().isNotEmpty &&
          passwordTextController.text.trim().isNotEmpty) {
        loginBloc.add(
          LoginDataEvent(
            username: userNameTextController.text.trim(),
            password: passwordTextController.text.trim(),
          ),
        );
      } else {
        toasterService.displayWarningMotionToast(
          context,
          "Please fill all fields!",
        );
      }
    } catch (e) {
      toasterService.displayErrorMotionToast(
        context: context,
        content: Text(
          "Failed to verify license. Please check your network or contact admin.",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              BlocConsumer<LoginBloc, LoginState>(
                bloc: loginBloc,
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    toasterService.displaySuccessMotionToast(
                      context: context,
                      content: Text("Login Successfully!"),
                    );
                    final session = SessionManagerClass();
                    session.getusertype().then((value) {
                      if (adminUserList.contains(value)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      }
                    });
                  }
                  if (state is LoginError) {
                    toasterService.displayErrorMotionToast(
                      context: context,
                      content: Text("Login Failed!"),
                    );
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Lottie.asset(
                              Assets.lotties.loginanimation,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            hintText: "Username",
                            obscureText: false,
                            controller: userNameTextController,
                            onSubmitted: (p0) {
                              FocusScope.of(
                                context,
                              ).requestFocus(passwordfocus);
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          width: 400,
                          child: MyTextField(
                            hintText: "Password",
                            obscureText: true,
                            focusNode: passwordfocus,
                            controller: passwordTextController,
                            onSubmitted: (p0) {
                              submit();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  showForgotPasswordDialog(context);
                                },
                                child: AppText.medium(
                                  "Forgot Password",
                                  color: Colors.blue,
                                  fontSize: 15,
                                ).withPadding(
                                  padding: EdgeInsets.only(top: 05.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        InkWell(
                          onTap: () {
                            submit();
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color(0xFF2196F3),
                              borderRadius: BorderRadius.circular(07),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 07,
            right: 07,
            child: Padding(
              padding: EdgeInsets.all(07.sp),
              child: InkWell(
                onTap: () {
                  showLicenseDialog(context);
                },
                child: Icon(Icons.settings, color: Colors.black, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
