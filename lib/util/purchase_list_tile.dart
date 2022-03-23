import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/purchase_list_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class PurchaseListTile extends StatelessWidget {
  const PurchaseListTile({Key? key,required this.model}) : super(key: key);
  final Purchase model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dynamicSize(.02)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02))),
      ),
      child: RichText(
        text: TextSpan(
          style: StDecoration.normalTextStyle,
          children: [
            const TextSpan(text: 'পণ্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.product!.chalanNo}\n'),
            const TextSpan(text: 'প্রকৃত ক্রয় মূল্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.actualPurchasPrice}\n'),
            const TextSpan(text: 'সরবরাহকারী: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.product!.partyName}\n'),
            const TextSpan(text: 'পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.quantity}\n'),
            const TextSpan(text: 'প্রকৃত পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.mainQuantity}\n'),
            const TextSpan(text: 'ইউনিট মূল্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.unitPrice}\n'),
            const TextSpan(text: 'প্রকৃত ক্রয় মূল্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.actualPurchasPrice}\n'),
            const TextSpan(text: 'পরিশোধিত অর্থ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.paymentAmount}\n'),
            const TextSpan(text: 'বাকির পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.due}\n'),
            const TextSpan(text: 'স্ট্যাটাস: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.status==0?'unpaid':'paid'}\n'),
            const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
