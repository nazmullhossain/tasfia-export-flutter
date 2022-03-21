import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:tashfia_export/variables/variable.dart';
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('পাসওয়ার্ড পরিবর্তন করুন', style:StDecoration.boldTextStyle),
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

  Widget _bodyUI(PublicController pc)=>Container(
    margin: EdgeInsets.all(dynamicSize(.04)),
    padding: EdgeInsets.all(dynamicSize(.05)),
    decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8))
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('আপনার পাসওয়ার্ড আপডেট করুন',style: StDecoration.boldTextStyle),
          SizedBox(height: dynamicSize(.08)),
          TextFieldTile(controller:  _currentPass, labelText: 'বর্তমান পাসওয়ার্ড'),
          SizedBox(height: dynamicSize(.06)),
          TextFieldTile(controller:  _newPass, labelText: 'নতুন পাসওয়ার্ড'),
          SizedBox(height: dynamicSize(.06)),
          TextFieldTile(controller:  _confirmPass, labelText: 'নতুন পাসওয়ার্ড নিশিচিত করুন'),
          SizedBox(height: dynamicSize(.06)),

          ColorTextButton(
            onPressed: ()async{
              if(_currentPass.text.isNotEmpty && _newPass.text.isNotEmpty && _confirmPass.text.isNotEmpty){
                if(_currentPass.text == pc.pref!.getString('password')){
                  if(_newPass.text == _confirmPass.text){
                    if(_newPass.text.length>=6 && _confirmPass.text.length>=6){
                      await pc.changePassword(_currentPass.text, _newPass.text, _confirmPass.text);
                      _currentPass.clear();_newPass.clear();_confirmPass.clear();
                    }else {showToast('পাসওয়ার্ড অবশ্যই ছয় অক্ষরের হতে হবে');}
                  }else {showToast('পাসওয়ার্ড মেলেনি');}
                }else {showToast('বর্তমান পাসওয়ার্ডটি ভুল');}
              }else {showToast('সমস্ত তথ্য প্রদান করুন');}
            },
            text: 'আপডেট করুন',
            minimumSize: Size(dynamicSize(.45),dynamicSize(.1)),
            buttonColor: Colors.green,
          )
        ],
      ),
    ),
  );
}
