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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1350),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  initState(){
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    await Future.delayed(const Duration(seconds: 2));
    if(PublicController.pc.pref!.getString('email')!=null
        && PublicController.pc.pref!.getString('password')!=null){
      await PublicController.pc.login(
          PublicController.pc.pref!.getString('email')!,
          PublicController.pc.pref!.getString('password')!);
    }else{
      Future.delayed(const Duration(seconds: 3)).then((value) =>
          Get.offAll(()=>const LoginPage()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (publicController) {
        if(publicController.size.value<=0.0) publicController.initApp(context);
        return Scaffold(
          backgroundColor: const Color(0xffF7F7F7),
          body: Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png',
                      width: dynamicSize(.7),
                      fit: BoxFit.cover),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: const Color(0xffFF002D),fontSize: dynamicSize(.09),fontWeight: FontWeight.w900),
                      children: const <TextSpan>[
                        TextSpan(text: 'Tashfia'),
                        TextSpan(text: ' Export', style: TextStyle(color: Colors.purple)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
