import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/advance_sales_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class AdvanceSaleTile extends StatelessWidget {
  const AdvanceSaleTile({Key? key,required this.model}) : super(key: key);
  final AdvanceSaleModel model;

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
            const TextSpan(text: 'আইডি: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.id}\n'),
            const TextSpan(text: 'পণ্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.product!.chalanNo??model.product!.chalanNo2}\n'),
            const TextSpan(text: 'পার্টির নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.party!.name}\n'),
            const TextSpan(text: 'ফোন: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.phone??''}\n'),
            const TextSpan(text: 'কোম্পানি: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.party!.company!.companyName}\n'),
            const TextSpan(text: 'মোট: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.totalAmount}\n'),
            const TextSpan(text: 'বকেয়ার তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(model.dueDate!)}\n'),
            const TextSpan(text: 'নিবন্ধন তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.invoiceDate!)),
          ],
        ),
      ),
    );
  }
}
