import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/sell_list_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class SellListTile extends StatelessWidget {
  const SellListTile({Key? key,required this.model}) : super(key: key);
  final SellModel model;

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
            const TextSpan(text: 'কাস্টমার: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.customerId}\n'),
            const TextSpan(text: 'সর্বমোট পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.totalPrice}\n'),
            const TextSpan(text: 'পরিশোধিত টাকার পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.paymentAmount}\n'),
            const TextSpan(text: 'বাকি: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.due}\n'),
            const TextSpan(text: 'ইনভয়েজ নাম্বার: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.salesCode}\n'),
            const TextSpan(text: 'স্ট্যাটাস: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.status}\n'),
            const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
