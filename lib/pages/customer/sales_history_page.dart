import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import '../../model/customer_model.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({Key? key,required this.model}) : super(key: key);
  final Customer model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return model.salesHistory!=null
            ?ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
            itemCount: model.salesHistory!.length,
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
                    const TextSpan(text: 'ক্রমিক নং: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${index+1}\n'),
                    const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(model.salesHistory![index].updatedAt!)}\n'),
                    const TextSpan(text: 'বিক্রয় কোড: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.salesHistory![index].salesCode??''}\n'),
                    const TextSpan(text: 'মোট চালানের মূল্য: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.salesHistory![index].totalPrice??''} ৳\n'),
                    const TextSpan(text: 'পরিশোধ পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.salesHistory![index].paymentAmount??0.0} ৳\n'),
                    const TextSpan(text: 'বকেয়া: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.salesHistory![index].due??0.0} ৳\n'),
                    const TextSpan(text: 'লেনদেনের অবস্থা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: model.salesHistory![index].status==0?'অপরিশোধিত':'পরিশোধিত'),

                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container();
      }
    );
  }
}
