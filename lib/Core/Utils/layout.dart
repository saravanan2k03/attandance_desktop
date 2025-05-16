import 'package:act/Core/Constants/constant.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final Widget? desktop;
  final Widget? mobile;
  final Widget? tablet;
  const Layout({super.key, this.desktop, this.mobile, this.tablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileConstraints) {
          return mobile ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mobile View",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
        } else if (constraints.maxWidth < 1200) {
          ////Tablet View
          return tablet ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mobile View",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
        } else {
          return desktop ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mobile View",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
        }
      },
    );
  }
}
