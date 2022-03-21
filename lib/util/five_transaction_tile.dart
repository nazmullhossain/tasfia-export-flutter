import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/model/five_transaction_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/color_variable.dart';
import 'package:tashfia_export/variables/config.dart';

class FiveTransactionTile extends StatelessWidget {
  const FiveTransactionTile({Key? key,required this.model}) : super(key: key);
  final FiveTransactionModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(LineAwesomeIcons.check_circle,color: AllColor.secondaryColor,size: dynamicSize(.1)),
        SizedBox(width: dynamicSize(.03)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mr. Rakib Hossain',style: StDecoration.boldTextStyle.copyWith(color: AllColor.secondaryColor)),
              Text('পরিমান: ${model.amount}/=',style: StDecoration.normalTextStyle),
              Text('পেমেন্টের ধরন: ${model.paymentMode}',style: StDecoration.normalTextStyle),
              Text('তারিখ: ${DateFormat('dd-MMM-yyyy').format(model.updatedAt!)}',style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.038),fontStyle: FontStyle.italic))
            ],
          ),
        )
      ],
    );
  }
}
