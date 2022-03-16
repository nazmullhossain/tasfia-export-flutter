import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/color_variable.dart';
import '../../variables/config.dart';
import '../../variables/variable.dart';

class DepositExpenses extends StatefulWidget {
  const DepositExpenses({Key? key,required this.gotAllData}) : super(key: key);
  final bool gotAllData;

  @override
  State<DepositExpenses> createState() => _DepositExpensesState();
}

class _DepositExpensesState extends State<DepositExpenses> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(dynamicSize(.04)),
              padding: EdgeInsets.all(dynamicSize(.04)),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: dynamicSize(.04)),

                    InkWell(
                      onTap: ()=>_selectFromDate(),
                      child: Container(
                        padding: EdgeInsets.all(dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius:const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey, width: 0.5)
                        ),
                        child: Row(
                          children: [
                            Text('From Date: ',style: StDecoration.boldTextStyle),
                            Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_fromDate),style: StDecoration.normalTextStyle)),
                            Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                          ],
                        ),
                      ),
                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                    ),
                    SizedBox(height: dynamicSize(.08)),

                    InkWell(
                      onTap: ()async{
                        await _selectToDate();
                        await PublicController.pc.getAccountSummery(
                            '${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
                            '${_toDate.year}-${_toDate.month}-${_toDate.day}');
                      },
                      child: Container(
                        padding: EdgeInsets.all(dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius:const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey, width: 0.5)
                        ),
                        child: Row(
                          children: [
                            Text('To Date: ',style: StDecoration.boldTextStyle),
                            Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_toDate),style: StDecoration.normalTextStyle)),
                            Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                          ],
                        ),
                      ),
                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                    ),
                    SizedBox(height: dynamicSize(.08)),

                    const Divider(color: AllColor.primaryColor,thickness: 2),
                    SizedBox(height: dynamicSize(.08)),

                    if(widget.gotAllData)Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: StDecoration.normalTextStyle,
                            children: [
                              const TextSpan(text: 'মোট জমা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${pc.accountSummery.value.profit}\n'),
                              const TextSpan(text: 'মোট খরচ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${pc.accountSummery.value.expense}'),
                            ],
                          ),
                        ),
                        Divider(color: Colors.blueGrey,thickness: 1,height: dynamicSize(.05)),
                        RichText(
                          text: TextSpan(
                            style: StDecoration.normalTextStyle,
                            children: [
                              const TextSpan(text: 'ক্যাশ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${pc.accountSummery.value.profit!-pc.accountSummery.value.expense!}\n'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    );
  }

  Future<void> _selectFromDate() async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _fromDate,
        firstDate: DateTime(2021),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(()=> _fromDate = selectedDate);
    }else{showToast('No date selected');}
  }

  Future<void> _selectToDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _toDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(()=> _toDate = selectedDate);
    }else{showToast('No date selected');}
  }
}

