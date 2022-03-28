import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';
import '../model/product_list_model.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key,required this.model}) : super(key: key);
  final Products model;

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
            const TextSpan(text: 'পণ্যের নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.chalanNo}\n'),
            const TextSpan(text: 'পার্টির নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.partyName}\n'),
            const TextSpan(text: 'রঙের নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.colorName}\n'),
            const TextSpan(text: 'S/L নম্বর: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.slNo}\n'),
            const TextSpan(text: 'G.G.S.M: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.ggsm}\n'),
            const TextSpan(text: 'কার্ড নাম্বার: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.cardNo}\n'),
            const TextSpan(text: 'রোল: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.roll}\n'),
            const TextSpan(text: 'ফ্যাব্রিক প্রাপ্তির তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
