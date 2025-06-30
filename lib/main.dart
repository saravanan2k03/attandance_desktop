import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';

import 'Core/Constants/constant.dart';
import 'Core/Data/Repository/core_repo.dart';
import 'Core/Services/misc.dart';
import 'Core/Services/observer.dart';
import 'Core/Services/service_locator.dart';
import 'Core/Services/session_manager.dart';
import 'Core/Utils/Theme/theme.dart';
import 'Features/Auth/Bloc/bloc/login_bloc.dart';
import 'Features/Auth/Presentation/Screens/auth.dart';
import 'Features/Dashboard/Presentation/dashboard.dart';
import 'Features/EmployeeManagement/Screens/AddEmployeeData/new_leave_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyGlobalObserver();

  await dotenv.load(fileName: "dotenv");

  await Hive.initFlutter();
  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> getInitialScreen() async {
    final session = SessionManagerClass();
    final licenseRepo = LicenseRepo();
    var licenseKey1 = await session.getlicence();
    await getuserType();
    fetchDepartmentsAndDesignations(licenseKey1);

    try {
      final accessToken = await session.getAccessToken();
      final refreshToken = await session.getRefreshToken();
      final userId = await session.getuserid();
      final username = await session.getusername();
      final email = await session.getemail();
      final userType = await session.getusertype();
      final licenseKey = await session.getlicence();

      final allFieldsExist =
          accessToken.isNotEmpty &&
          refreshToken.isNotEmpty &&
          userId.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          userType.isNotEmpty &&
          licenseKey.isNotEmpty;

      if (!allFieldsExist) {
        return Auth();
      }

      final licenseStatus = await licenseRepo.checkLicenseStatus(licenseKey);
      if (!licenseStatus.activated) {
        return Auth();
      }

      log(userType);
      if (adminUserList.contains(userType)) {
        return Dashboard();
      } else {
        int number = int.parse(userId);
        return LeaveRequestScreen(userId: number);
      }
    } catch (e) {
      return Auth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'ACT',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          navigatorKey: MyApp.navigatorKey,
          routes: {'/login': (context) => const Auth()},
          home: FutureBuilder<Widget>(
            future: getInitialScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return snapshot.data!;
              } else {
                return const Auth();
              }
            },
          ),
        );
      },
    );
  }
}
