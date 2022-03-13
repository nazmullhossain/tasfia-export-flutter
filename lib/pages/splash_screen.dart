import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/public_controller.dart';
import '../variables/config.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Get.offAll(()=>const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (publicController) {
        if(publicController.size.value<=0.0) publicController.initApp(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text('Tashfia Export',
                style: TextStyle(fontSize: dynamicSize(.05),
                    color: Theme.of(context).primaryColor)),
            // child: Image.asset('assets/sukhtara_logo.jpg',
            //     height:dynamicSize(.7),
            //     fit: BoxFit.cover),
          ),
        );
      }
    );
  }
}
