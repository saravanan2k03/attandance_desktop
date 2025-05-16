import 'package:act/Core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class LoginDesktopView extends StatelessWidget {
  LoginDesktopView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode unitCodeCtrlFocusNode = FocusNode();
  bool obsecuretext = true;
  bool checkboxvalue = false;
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (checkboxvalue == true && !value.contains('@')) {
      return 'Invalid email format';
    }
    if (checkboxvalue == true && !value.contains('amrita.edu')) {
      return 'Enter a valid Amrita Email Id';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // color: Colors.red,
                    height: 65.sp,
                    width: 50.sp,

                    // child: Assets.icons.sreeappicon.svg(),
                    child: Lottie.asset(
                      Assets.lotties.loginanimation,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.width * 0.20,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextFormField(
                      validator: validateEmail,
                      obscureText: false,
                      decoration: const InputDecoration(hintText: 'Email'),
                      onFieldSubmitted: (value) {
                        FocusScope.of(
                          context,
                        ).requestFocus(unitCodeCtrlFocusNode);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.width * 0.20,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextFormField(
                      validator: validatePassword,
                      obscureText: obsecuretext,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: InkWell(
                          onTap: () {},
                          child:
                              obsecuretext
                                  ? const Icon(Icons.remove_red_eye_rounded)
                                  : const Icon(Icons.remove_red_eye),
                        ),
                      ),
                      focusNode: unitCodeCtrlFocusNode,
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 05),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: const Color(0xff475BE8),
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
