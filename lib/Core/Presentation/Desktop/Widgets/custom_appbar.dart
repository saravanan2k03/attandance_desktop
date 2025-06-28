import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/hive_services.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Auth/Presentation/Screens/auth.dart';
import 'package:act/Features/Auth/Repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  void initState() {
    getuserType();
    super.initState();
  }

  final AuthRepo authRepo = AuthRepo();
  final HiveServices hiveServices = HiveServices();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23.sp,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Container()),
          Row(
            children: [
              InkWell(
                onTap: () {
                  authRepo.logoutapi().whenComplete(() {
                    hiveServices.deleteallData().then((value) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(builder: (context) => const Auth()),
                      );
                    });
                  });

                  // getIt.get<LoginBloc>().add(LogOutEvent());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Row(
                    children: [AppText.small("Logout", fontSize: 17)],
                  ).withPadding(padding: EdgeInsets.all(07.sp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
