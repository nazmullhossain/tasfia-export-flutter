import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/pages/splash_screen.dart';
import 'package:tashfia_export/variables/variable.dart';

import 'controller/public_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Variables.statusBarTheme;
  Variables.portraitMood;
  final PublicController publicController = Get.put(PublicController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tashfia Export',
      debugShowCheckedModeBanner: false,
      theme: Variables.themeData,
      home: const SplashScreen(),
    );
  }
}
