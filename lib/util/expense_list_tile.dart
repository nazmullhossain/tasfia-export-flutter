import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/expense_list_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({Key? key,required this.model, required this.index}) : super(key: key);
  final ExpenseModel model;
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
            const TextSpan(text: 'ক্যাটাগরী: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.id}\n'),
            const TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.name}\n'),
            const TextSpan(text: 'পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.amount}\n'),
            const TextSpan(text: 'রিমার্ক্স: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.remarks}\n'),
            const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
