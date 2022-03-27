import 'package:flutter/material.dart';
import '../util/decoration.dart';
import '../variables/config.dart';

class BlackContainer extends StatelessWidget {
  const BlackContainer({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal:dynamicSize(.04),vertical: dynamicSize(.01)),
        margin: EdgeInsets.symmetric(horizontal:dynamicSize(.02)),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius:const BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: Colors.grey,width: 0.5)
        ),
        child: Text(title,style: StDecoration.boldTextStyle.copyWith(color: Colors.white))
    );
  }
}
