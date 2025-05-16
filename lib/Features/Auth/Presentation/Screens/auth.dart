import 'package:act/Core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 15,
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
                  width: 300,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'Password'),
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 2.h),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff3083dc),
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
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(07.sp),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
