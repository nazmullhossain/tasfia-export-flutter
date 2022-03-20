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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: StDecoration.normalTextStyle,
              children: [
                const TextSpan(text: 'Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.status}\n'),
                const TextSpan(text: 'Actual purchase price: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.actualPurchasPrice}\n'),
                const TextSpan(text: 'Actual unit price: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.actualUnitPrice}\n'),
                const TextSpan(text: 'Quantity: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.mainQuantity}\n'),
                const TextSpan(text: 'Payment Amount: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.paymentAmount}\n'),
                const TextSpan(text: 'Due Amount: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.due}\n'),
                const TextSpan(text: 'Total purchase price: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${model.totalPurchasPrice}\n'),
                const TextSpan(text: 'Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
