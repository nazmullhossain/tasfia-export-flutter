import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/pages/supplier/supplier_details_page.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/color_variable.dart';
import 'package:tashfia_export/variables/config.dart';

class SupplierListTile extends StatelessWidget {
  const SupplierListTile({Key? key,required this.model}) : super(key: key);
  final Supplier model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>SupplierDetailsPage(model: model));
      },
      child: Container(
        padding: EdgeInsets.all(dynamicSize(.02)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: dynamicSize(.13),
              width: dynamicSize(.13),
             decoration: const BoxDecoration(
               shape: BoxShape.circle,
               color: AllColor.primaryColor,
             ),
              child: model.photo!=null && model.photo!.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.1))),
                child: CachedNetworkImage(
                  imageUrl: model.photo!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(color: Colors.white,radius: dynamicSize(.03)),
                  errorWidget: (context, url, error) => Icon(LineAwesomeIcons.exclamation,color:Colors.white,size: dynamicSize(.07)),
                ),
              )
                  : Icon(LineAwesomeIcons.user,color: Colors.white,size: dynamicSize(.08)),
            ),
            SizedBox(width: dynamicSize(.03)),

            Expanded(
              child: RichText(
                text: TextSpan(
                  style: StDecoration.normalTextStyle,
                  children: [
                    const TextSpan(text: 'আইডি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.id}\n'),
                    const TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.name}\n'),
                    const TextSpan(text: 'ফোন: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.personalPhone??model.optionalPhone}\n'),
                    const TextSpan(text: 'ঠিকানা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.permanentAddress??model.presentAddress}\n'),
                    const TextSpan(text: 'কোম্পানির নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '${model.company!.companyName}\n'),
                    const TextSpan(text: 'আগের বকেয়া: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'No Data\n'),
                    const TextSpan(text: 'মোট বাকি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: 'No Data'),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
