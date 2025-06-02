import 'package:flutter/material.dart';

const desktopConstraints = 1100;
const mobileConstraints = 600;

Size calcSize(context) {
  return MediaQuery.of(context).size;
}
