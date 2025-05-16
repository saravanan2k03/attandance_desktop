import 'package:act/Core/Utils/Theme/theme.dart';
import 'package:act/Features/Auth/Presentation/Screens/auth.dart';
import 'package:act/Features/Auth/Presentation/Screens/auth_two.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (concontext, orientation, screenTypetext) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          home: Auth(),
        );
      },
    );
  }
}
