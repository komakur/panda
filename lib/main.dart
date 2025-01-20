import 'package:flutter/material.dart';
import 'package:panda/app/app.dart';
import 'package:panda/app/app_initialization.dart';

void main() async {
  await initializeApp();

  runApp(const PandaApp());
}
