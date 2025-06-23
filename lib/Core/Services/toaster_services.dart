import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class ToasterService {
  void displaySuccessMotionToast({
    required BuildContext context,
    required Text content,
  }) {
    MotionToast toast = MotionToast.success(
      description: content,
      toastAlignment: Alignment.bottomRight,
      enableAnimation: true,

      barrierColor: Colors.black.withValues(alpha: 0.3),
      toastDuration: Duration(seconds: 03),
      // width: 300,
      // height: 80,
      dismissable: false,
      opacity: .5,
    );
    toast.show(context);
  }

  void displayWarningMotionToast(BuildContext context) {
    MotionToast.warning(
      title: const Text(
        'Warning Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('This is a Warning'),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
      opacity: .9,
    ).show(context);
  }

  void displayErrorMotionToast({
    required BuildContext context,
    required Text content,
  }) {
    MotionToast.error(
      title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
      description: content,
      toastAlignment: Alignment.bottomRight,
      enableAnimation: true,

      barrierColor: Colors.black.withValues(alpha: 0.3),
      toastDuration: Duration(seconds: 03),
      // width: 300,
      // height: 80,
      dismissable: false,
    ).show(context);
  }

  void displayInfoMotionToast(BuildContext context) {
    MotionToast.info(
      title: const Text(
        'Info Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      toastAlignment: Alignment.center,
      description: const Text('Example of Info Toast'),
    ).show(context);
  }

  void displayResponsiveMotionToast(BuildContext context) {
    MotionToast(
      icon: Icons.rocket_launch,
      primaryColor: Colors.purple,
      title: const Text(
        'Custom Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('Hello my name is Flutter dev'),
    ).show(context);
  }

  void displayCustomMotionToast(BuildContext context) {
    MotionToast(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.10,
      primaryColor: Colors.pink,
      title: const Text(
        'Bugatti',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      dismissable: false,
      description: const Text(
        'Automobiles Ettore Bugatti was a German then French manufacturer of high-performance automobiles. The company was founded in 1909 in the then-German city of Molsheim, Alsace, by the Italian-born industrial designer Ettore Bugatti. ',
      ),
    ).show(context);
  }

  void displayMotionToastWithoutSideBar(BuildContext context) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.orange[500]!,
      secondaryColor: Colors.grey,
      title: const Text('Two Color Motion Toast'),
      description: const Text('Another motion toast example'),
      displayBorder: true,
      displaySideBar: false,
    ).show(context);
  }

  void displayMotionToastWithBorder(BuildContext context) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.deepOrange,
      title: const Text('Top Motion Toast'),
      description: const Text('Another motion toast example'),
      toastAlignment: Alignment.topCenter,
      animationType: AnimationType.slideInFromTop,
      displayBorder: true,
      width: 350,
      height: 100,
      margin: const EdgeInsets.only(top: 30),
    ).show(context);
  }

  void displayTwoColorsMotionToast(BuildContext context) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.orange[500]!,
      secondaryColor: Colors.grey,
      title: const Text(
        'Two Color Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('Another motion toast example'),
      toastAlignment: Alignment.topCenter,
      animationType: AnimationType.slideInFromTop,
      width: 350,
      height: 100,
    ).show(context);
  }

  void displayTransparentMotionToast(BuildContext context) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.grey[400]!,
      secondaryColor: Colors.yellow,
      title: const Text(
        'Two Color Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('Another motion toast example'),
      toastAlignment: Alignment.center,
      width: 350,
      height: 100,
    ).show(context);
  }

  void displaySimultaneouslyToasts(BuildContext context) {
    MotionToast.warning(
      title: const Text(
        'Warning Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('This is a Warning'),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
    MotionToast.error(
      title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
      description: const Text('Please enter your name'),
      animationType: AnimationType.slideInFromLeft,
      toastAlignment: Alignment.topCenter,
      width: 300,
      height: 80,
    ).show(context);
  }

  void displayCustomToastAlignment(BuildContext context) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: Colors.orange[500]!,
      secondaryColor: Colors.grey,
      title: const Text(
        'Two Color Motion Toast',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      description: const Text('Another motion toast example'),
      toastAlignment: const Alignment(0.5, -0.8),
      width: 350,
      height: 100,
    ).show(context);
  }
}
