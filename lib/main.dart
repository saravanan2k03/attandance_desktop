import 'package:act/Core/Services/observer.dart';
import 'package:act/Core/Utils/Theme/theme.dart';
import 'package:act/Features/Auth/Presentation/Screens/auth.dart';
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
