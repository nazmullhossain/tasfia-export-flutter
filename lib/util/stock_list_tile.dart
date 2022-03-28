import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/stock_list_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class StockListTile extends StatelessWidget {
  const StockListTile({Key? key,required this.model}) : super(key: key);
  final StockModel model;

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
            const TextSpan(text: 'পন্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.purchase!.product!.chalanNo??model.purchase!.product!.chalanNo2}\n'),
            const TextSpan(text: 'সরবরাহকারী: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.purchase!.supplier!.name}\n'),
            const TextSpan(text: 'পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.quantity} kg\n'),
            const TextSpan(text: 'লভ্য পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.mainQuantity} kg\n'),
            const TextSpan(text: 'বার কোড নম্বর: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.purchase!.product!.cardNo}\n'),
            const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
