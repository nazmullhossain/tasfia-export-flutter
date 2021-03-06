import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/opening_balance_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class OpeningBalanceTile extends StatelessWidget {
  const OpeningBalanceTile({Key? key,required this.model, required this.index}) : super(key: key);
  final OpeningBalanceModel model;
  final int index;

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
            const TextSpan(text: 'S/L নং: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${index+1}\n'),
            const TextSpan(text: 'ওপেনিং ব্যালেন্স: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.openingBalance}\n'),
            const TextSpan(text: 'ক্লোজিং ব্যালেন্স: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.closingBalance}\n'),
            const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
