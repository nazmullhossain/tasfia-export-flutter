import 'package:flutter/material.dart';
import 'package:tashfia_export/model/home_menu_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

 class DashboardTile extends StatelessWidget {
   const DashboardTile({Key? key,required this.model}) : super(key: key);
   final HomeMenuModel model;

   @override
   Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         color: model.color.withOpacity(.5),
         borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02)))
       ),
       child: ListTile(
         title: Text(model.title,style: 
         StDecoration.boldTextStyle.copyWith(color: Colors.white,fontSize: dynamicSize(.05))),
         trailing: Icon(model.icon,size: dynamicSize(.12),color: Colors.white),
       ),
     );
   }
 }
