import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/color_variable.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:intl/intl.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({Key? key,required this.model}) : super(key: key);
  final Customer model;

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
          Container(
            height: dynamicSize(.13),
            width: dynamicSize(.13),
           decoration: const BoxDecoration(
             shape: BoxShape.circle,
             color: AllColor.primaryColor,
           ),
            child: model.photo!= null && model.photo!.isNotEmpty
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
                  const TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.name}\n'),
                  const TextSpan(text: 'ফোন: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.personalPhone??model.optionalPhone}\n'),
                  const TextSpan(text: 'ইমেইল: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.email}\n'),
                  const TextSpan(text: 'এন.আইডি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.nid}\n'),
                  const TextSpan(text: 'ঠিকানা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.permanentAddress??model.presentAddress}\n'),
                  const TextSpan(text: 'ব্যালেন্স: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.balance}\n'),
                  const TextSpan(text: 'পদবী: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.designation}\n'),
                  const TextSpan(text: 'প্রতিষ্ঠানের নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.companyName??'Not added yet'}\n'),
                  const TextSpan(text: 'ধরন: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.type}\n'),
                  const TextSpan(text: 'রেফারেন্স: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.reference}\n'),
                  const TextSpan(text: 'জাতীয়তা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${model.nationality}\n'),
                  const TextSpan(text: 'জয়েন ডেট: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
