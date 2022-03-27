import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import '../../model/customer_model.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';

class DuePaymentHistoryPage extends StatelessWidget {
  const DuePaymentHistoryPage({Key? key,required this.model}) : super(key: key);
  final Customer model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
        builder: (pc) {
          return model.paymentHistory!=null
              ?ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
              itemCount: model.paymentHistory!.length,
              itemBuilder: (context, index)=> Container(
                padding: EdgeInsets.all(dynamicSize(.02)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02))),
                ),
                child: RichText(
                  text: TextSpan(
                    style: StDecoration.normalTextStyle,
                    children: [
                      const TextSpan(text: 'আইডি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${index+1}\n'),
                      const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(model.paymentHistory![index].updatedAt!)}\n'),
                      const TextSpan(text: 'পরিশোধের মাধ্যম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${model.paymentHistory![index].salesCode??''}\n'),
                      const TextSpan(text: 'পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${model.paymentHistory![index].totalPrice??''}\n'),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container();
        }
    );
  }
}
