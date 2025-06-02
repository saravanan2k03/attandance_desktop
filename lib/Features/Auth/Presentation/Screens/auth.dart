import 'package:act/Core/gen/assets.gen.dart';
import 'package:act/Features/Auth/Presentation/Widgets/my_textfield.dart';
import 'package:act/Features/Dashboard/Presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
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
                        hintText: "Email",
                        obscureText: false,
                        controller: TextEditingController(),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 400,
                      child: MyTextField(
                        hintText: "Password",
                        obscureText: true,
                        controller: TextEditingController(),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
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
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 07,
            right: 07,
            child: Padding(
              padding: EdgeInsets.all(07.sp),
              child: Icon(Icons.settings, color: Colors.black, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
