import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';

class PurchaseHistorySupplier extends StatelessWidget {
  const PurchaseHistorySupplier({Key? key,required this.model}) : super(key: key);
  final Supplier model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return model.purchase!=null
            ?ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
            itemCount: model.purchase!.length,
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
                    const TextSpan(text: 'SL: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${index+1}\n'),
                    const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(model.purchase![index].updatedAt!)}\n'),
                    const TextSpan(text: 'আইটেম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'No Data\n'),
                    const TextSpan(text: 'কোড: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'No Data\n'),
                    const TextSpan(text: 'পরিমান(kg): ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.purchase![index].quantity??0.0} ৳\n'),
                    const TextSpan(text: 'মোট ক্রয় মূল্য(TK): ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.purchase![index].totalPurchasPrice??0.0} ৳\n'),
                    const TextSpan(text: 'প্রকৃত ক্রয় মূল্য(TK): ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.purchase![index].actualPurchasPrice} ৳'),

                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container();
      }
    );
  }
}
