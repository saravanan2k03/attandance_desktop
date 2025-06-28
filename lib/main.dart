import 'dart:developer';

import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Data/Repository/core_repo.dart';
import 'package:act/Core/Services/misc.dart';
import 'package:act/Core/Services/observer.dart';
import 'package:act/Core/Services/service_locator.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/Theme/theme.dart';
import 'package:act/Features/Auth/Bloc/bloc/login_bloc.dart';
import 'package:act/Features/Auth/Presentation/Screens/auth.dart';
import 'package:act/Features/Dashboard/Presentation/dashboard.dart';
import 'package:act/Features/EmployeeManagement/Screens/AddEmployeeData/new_leave_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyGlobalObserver();
  String envFile;
  envFile = "dotenv";
  // envFile = "dotenvprod";
  await dotenv.load(fileName: envFile);

  ///Hive initialization
  await Hive.initFlutter();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Widget> getInitialScreen() async {
      final session = SessionManagerClass();
      final licenseRepo = LicenseRepo();
      var licenseKey1 = await session.getlicence();
      await getuserType();
      // generateBeautifulReport();
      fetchDepartmentsAndDesignations(licenseKey1);
      try {
        // Check for required session values
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
          return Auth(); // Incomplete session
        }

        // Verify license key with API
        final licenseStatus = await licenseRepo.checkLicenseStatus(licenseKey);
        if (!licenseStatus.activated) {
          return Auth(); // Invalid license
        }
        log(userType);
        if (adminUserList.contains(userType)) {
          return Dashboard();
        } else {
          return LeaveRequestScreen();
        }

        // Everything is valid
        // Replace with your actual dashboard screen
      } catch (e) {
        return Auth(); // Any exception goes to auth screen
      }
    }

    return Sizer(
      builder: (concontext, orientation, screenTypetext) {
        return MaterialApp(
          title: 'ACT',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          home: BlocConsumer<LoginBloc, LoginState>(
            bloc: getIt.get<LoginBloc>(),
            listener: (context, state) {
              if (state is LogoutSucess) {
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const Auth()),
                );
              }
              if (state is LoginError) {
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const Auth()),
                );
              }
            },
            builder: (context, state) {
              return FutureBuilder<Widget>(
                future: getInitialScreen(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return Auth(); // fallback
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
