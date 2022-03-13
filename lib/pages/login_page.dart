import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/util/decoration.dart';
import '../controller/public_controller.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/loading_widget.dart';
import '../widgets/round_gradient_button.dart';
import '../widgets/text_field_tile.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  Future<void> _autoLogin()async{
    await Future.delayed(const Duration(milliseconds: 50));
    if(PublicController.pc.pref!.getString('username')!=null){
      // await PublicController.pc.loginUser(
      //     PublicController.pc.pref!.getString('username')!,
      //     PublicController.pc.pref!.getString('password')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.center,
            children: [
              ///Top Container
              Positioned(
                top: 0.0,
                left: 0.0,
                child: Stack(
                  children: [
                    Container(
                      height: dynamicSize(.28),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(.2),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(size.width)
                          )
                      ),
                    ),
                    Container(
                      height: dynamicSize(.25),
                      width: size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow,
                            Colors.deepOrange.shade400
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(size.width)
                        )
                      ),
                    ),
                  ],
                ),
              ),

              ///Bottom Container
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: dynamicSize(.28),
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(.2),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width)
                          )
                      ),
                    ),
                    Container(
                      height: dynamicSize(.25),
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient:LinearGradient(
                            colors: [
                              Colors.cyanAccent,
                              Colors.lightBlue.shade600
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width)
                          )
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Login Title
                  Center(child: Text('Login',
                      style: StDecoration.boldTextStyle.copyWith(
                        fontSize: dynamicSize(.07),
                        fontWeight: FontWeight.w600,
                      ))),
                  SizedBox(height: dynamicSize(.15)),

                  ///Username Password field
                  Stack(
                    alignment: Alignment.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      ///TextField Container
                      Container(
                        //width: size.width*.85,
                        margin: EdgeInsets.only(right: dynamicSize(.11)),
                        decoration:  StDecoration.loginRegDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: dynamicSize(.04)),
                            TextFieldTile(controller: username,hintText: 'Username',
                              prefixIcon: LineAwesomeIcons.user),
                            const Divider(),
                            TextFieldTile(controller: password,hintText: '********',
                                obscure: true,prefixIcon: LineAwesomeIcons.key),
                            SizedBox(height: dynamicSize(.04)),
                          ],
                        ),
                      ),

                      Positioned(
                        right: dynamicSize(.05),
                        child: RoundGradientButton(
                          onTab: ()=> Get.to(()=>const HomePage()),
                          child: Icon(LineAwesomeIcons.arrow_right,
                              color: AllColor.whiteColor, size: dynamicSize(.07)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: dynamicSize(.06)),

                  ///Forgot Button
                  Padding(
                    padding: EdgeInsets.only(right: dynamicSize(.05),top: dynamicSize(.02)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){},
                          child: Text('Forgot ?',style: TextStyle(color: AllColor.hintColor,
                              fontWeight: FontWeight.bold,fontSize: dynamicSize(.045)))),
                    ),
                  ),
                ],
              ),
              if(pc.loading.value) const LoadingWidget()
            ],
          ),
        );
      }
    );
  }

  Future<void> verifyAndLogin()async{
    if(username.text.isNotEmpty && password.text.isNotEmpty){

    }else{
      showToast('Field can\'t be empty');
    }
  }
}
