import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tashfia_export/model/employee_model.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class AllEmployeeTile extends StatelessWidget {
  const AllEmployeeTile({Key? key,required this.model}) : super(key: key);
  final Employee model;

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
            const TextSpan(text: 'Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.name}\n'),
            const TextSpan(text: 'Phone: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.phone}\n'),
            const TextSpan(text: 'Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.email}\n'),
            const TextSpan(text: 'Address: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.address}\n'),
            const TextSpan(text: 'Salary: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: '${model.salary}\n'),
            const TextSpan(text: 'Join Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat('dd-MMM-yyyy').format(model.updatedAt!)),
          ],
        ),
      ),
    );
  }
}
