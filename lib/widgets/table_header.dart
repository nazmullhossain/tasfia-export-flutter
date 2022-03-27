import 'package:flutter/material.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';

class TableHeaderWidget extends StatelessWidget {
  const TableHeaderWidget({Key? key,required this.title,required this.title2}) : super(key: key);
  final String title, title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:dynamicSize(.02)),
      decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          )
      ),
      child: Row(
        children: [
          Container(
            width: dynamicSize(.1),
            padding: EdgeInsets.all(dynamicSize(.01)),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey))
            ),
            child: Text('#',style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
          ),
          Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))
                ),
                child: Text('পার্টি নাম',style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              )),
          Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))
                ),
                child: Text(title,style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              )),Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))
                ),
                child: Text(title2,style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              )),Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.center,
                child: Text('মোট টাকা',style: StDecoration.normalTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              )),
        ],
      ),
    );
  }
}




class TotalWidget extends StatelessWidget {
  const TotalWidget({Key? key,required this.title, required this.amount}) : super(key: key);
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:dynamicSize(.02)),
      decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey),
            right: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
          )
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.grey))
                ),
                child: Text(title,style: StDecoration.boldTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              )),
          Expanded(
              child: Container(
                width: dynamicSize(.1),
                padding: EdgeInsets.all(dynamicSize(.01)),
                alignment: Alignment.centerRight,
                child: Text(amount,style: StDecoration.boldTextStyle.copyWith(fontSize: dynamicSize(.035)),textAlign: TextAlign.center),
              ))
        ],
      ),
    );
  }
}

