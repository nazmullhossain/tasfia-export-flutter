import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/variables/config.dart';
import '../controller/public_controller.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../widgets/color_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_tile.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({Key? key}) : super(key: key);

  final TextEditingController _currentPass = TextEditingController(text: '');
  final TextEditingController _newPass = TextEditingController(text: '');
  final TextEditingController _confirmPass = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Change Password', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
            ),
            body: _bodyUI(pc),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Container(
          margin: EdgeInsets.all(dynamicSize(.08)),
          padding: EdgeInsets.all(dynamicSize(.05)),
          decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Change your password',style: StDecoration.boldTextStyle),
              SizedBox(height: dynamicSize(.08)),
              TextFieldTile(controller:  _currentPass, labelText: 'Current Password'),
              SizedBox(height: dynamicSize(.06)),
              TextFieldTile(controller:  _newPass, labelText: 'New Password'),
              SizedBox(height: dynamicSize(.06)),
              TextFieldTile(controller:  _confirmPass, labelText: 'Confirm New Password'),
              SizedBox(height: dynamicSize(.06)),

              ColorTextButton(
                onPressed: (){},
                text: 'Update Password',
                minimumSize: Size(dynamicSize(.45),dynamicSize(.1)),
                buttonColor: Colors.green,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
