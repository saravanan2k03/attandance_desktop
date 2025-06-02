import 'package:act/Core/Presentation/Desktop/Screens/custom_drawer.dart';
import 'package:act/Core/Presentation/Desktop/Widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: CustomDrawer(dashboard: true)),
          Expanded(
            flex: 13,
            child: Column(
              children: [
                CustomAppbar(),
                Expanded(child: Container(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
