import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import '../../model/customer_model.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';

class DuePaymentHistorySupplier extends StatelessWidget {
  const DuePaymentHistorySupplier({Key? key,required this.model}) : super(key: key);
  final Supplier model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
        builder: (pc) {
          return model.previousDuePaymentHistory!=null
              ?ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
              itemCount: model.previousDuePaymentHistory!.length,
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
                      TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(model.previousDuePaymentHistory![index].updatedAt!)}\n'),
                      const TextSpan(text: 'পরিশোধের মাধ্যম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${model.previousDuePaymentHistory![index].salesCode??''}\n'),
                      const TextSpan(text: 'পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '${model.previousDuePaymentHistory![index].totalPrice??''}\n'),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container();
        }
    );
  }
}
