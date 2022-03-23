import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../controller/pdf_helper/deposite_expense_pdf.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/color_variable.dart';
import '../../variables/config.dart';
import '../../variables/variable.dart';

class DepositExpenses extends StatefulWidget {
  const DepositExpenses({Key? key,required this.gotJoma}) : super(key: key);
  final bool gotJoma;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: ()=>_selectFromDate(),
                                child: Container(
                                  padding: EdgeInsets.all(dynamicSize(.02)),
                                  decoration: BoxDecoration(
                                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.blueGrey, width: 0.5)
                                  ),
                                  child: Row(
                                    children: [
                                      Text('From: ',style: StDecoration.boldTextStyle),
                                      Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_fromDate),style: StDecoration.normalTextStyle)),
                                      Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                                    ],
                                  ),
                                ),
                                borderRadius:const BorderRadius.all(Radius.circular(5)),
                              ),
                              SizedBox(height: dynamicSize(.04)),
                              InkWell(
                                onTap: ()async{
                                  await _selectToDate();
                                  await PublicController.pc.getAccountSummery(
                                    DateFormat('yyyy-MM-dd').format(_fromDate),
                                    DateFormat('yyyy-MM-dd').format(_toDate),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(dynamicSize(.02)),
                                  decoration: BoxDecoration(
                                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.blueGrey, width: 0.5)
                                  ),
                                  child: Row(
                                    children: [
                                      Text('To: ',style: StDecoration.boldTextStyle),
                                      Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_toDate),style: StDecoration.normalTextStyle)),
                                      Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                                    ],
                                  ),
                                ),
                                borderRadius:const BorderRadius.all(Radius.circular(5)),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: dynamicSize(.02)),
                        //if(pc.salesProfitLossModel.value.data!=null && pc.salesProfitLossModel.value.data!.isNotEmpty)
                        ElevatedButton(
                            onPressed: ()async{
                              await DepositExpenseReportPDF.generateDepositExpensePDFReport();
                            },
                            child: Text('Report',style: StDecoration.boldTextStyle.copyWith(color: Colors.white)))
                      ],
                    ),
                    SizedBox(height: dynamicSize(.04)),

                    const Divider(color: AllColor.primaryColor,thickness: 2),
                    SizedBox(height: dynamicSize(.04)),

                    if(widget.gotJoma)Column(
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
                        const Divider(color: Colors.blueGrey,thickness: 1,height: 0.0),
                        RichText(
                          text: TextSpan(
                            style: StDecoration.normalTextStyle,
                            children: [
                              const TextSpan(text: 'ক্যাশ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${double.parse(pc.accountSummery.value.profit!.toString())-double.parse(pc.accountSummery.value.expense!.toString())}'),
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
    }else{showToast('কোনো তারিখ নির্বাচন করা হয়নি');}
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
    }else{showToast('কোনো তারিখ নির্বাচন করা হয়নি');}
  }
}

