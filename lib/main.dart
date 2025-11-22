import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:developer';
import 'package:act/Core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:window_manager/window_manager.dart';
import 'Core/Constants/constant.dart';
import 'Core/Data/Repository/core_repo.dart';
import 'Core/Services/misc.dart';
import 'Core/Services/observer.dart';
import 'Core/Services/service_locator.dart';
import 'Core/Services/session_manager.dart';
import 'Core/Utils/Theme/theme.dart';
import 'Features/Auth/Presentation/Screens/auth.dart';
import 'Features/Dashboard/Presentation/dashboard.dart';
import 'Features/EmployeeManagement/Screens/AddEmployeeData/new_leave_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyGlobalObserver();
  // Initialize the window_manager plugin
  await windowManager.ensureInitialized();

  // Future.delayed(const Duration(milliseconds: 300), () async {
  //   await windowManager.setFullScreen(true);
  //   await _customizeWindow();
  // });
  await dotenv.load(fileName: "dotenv");
  if (!kIsWeb) {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
  } else {
    Hive.initFlutter(); // Use this for web platform
  }

  setupServiceLocator();

  runApp(const MyApp());
}

// Future<void> _customizeWindow() async {
//   if (!Platform.isWindows) return;

//   final hwnd = GetForegroundWindow();

//   final currentStyle = GetWindowLongPtr(hwnd, GWL_STYLE);

//   // Remove Maximize box and system menu (close), but keep Minimize box
//   final newStyle = currentStyle & ~WS_MAXIMIZEBOX; // keeps Minimize intact

//   SetWindowLongPtr(hwnd, GWL_STYLE, newStyle);

//   SetWindowPos(
//     hwnd,
//     0,
//     0,
//     0,
//     0,
//     0,
//     SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_FRAMECHANGED,
//   );
// }

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
    await getuserType();

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
      } else {
        await fetchDepartmentsAndDesignations();
      }

      log("User Type received: '$userType'");
      String normalizedUserType = userType.trim().toLowerCase();

      bool isAdmin = adminUserList.any(
        (role) => role.toLowerCase() == normalizedUserType,
      );

      if (isAdmin) {
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
          title: 'HourlyDots',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          navigatorKey: MyApp.navigatorKey,
          routes: {'/login': (context) => const Auth()},
          home: FutureBuilder<Widget>(
            future: getInitialScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: SvgPicture.asset(Assets.icons.hourlyDotSplashIcon)),
    );
  }
}
