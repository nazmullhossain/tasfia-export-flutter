import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/widgets/black_container.dart';
import 'package:tashfia_export/widgets/table_header.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';
import '../../variables/variable.dart';

class DepositExpenses extends StatefulWidget {
  const DepositExpenses({Key? key}) : super(key: key);

  @override
  State<DepositExpenses> createState() => _DepositExpensesState();
}

class _DepositExpensesState extends State<DepositExpenses> with SingleTickerProviderStateMixin{
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Search and Print Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal:dynamicSize(.04),vertical: dynamicSize(.02)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: (){_showSearchDialog(pc);},
                        child: Container(
                          padding: EdgeInsets.all(dynamicSize(.02)),
                          decoration: BoxDecoration(
                              borderRadius:const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.blueGrey, width: 0.5)
                          ),
                          child: Row(
                            children: [
                              Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07)),
                              Text(' Search',style: StDecoration.boldTextStyle)
                            ],
                          ),
                        ),
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),

                  SizedBox(width: dynamicSize(.02)),
                  ElevatedButton(
                      onPressed: ()async{
                        //await DepositExpenseReportPDF.generateDepositExpensePDFReport();
                      },
                      child: Text('Print Report',style: StDecoration.boldTextStyle.copyWith(color: Colors.white)))
                ],
              ),
            ),

            ///Data List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal:dynamicSize(.04)),
                shrinkWrap: true,
                children: [
                  ///জমা.................................
                  Container(
                    padding: EdgeInsets.symmetric(vertical: dynamicSize(.03)),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Column(
                      children: [

                        Text('জমা',style: StDecoration.boldTextStyle,textAlign: TextAlign.center),
                        ///ক্যাশ ইজা
                        Container(
                            margin: EdgeInsets.symmetric(horizontal:dynamicSize(.02)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:const BorderRadius.all(Radius.circular(2)),
                                border: Border.all(color: Colors.grey,width: 0.5)
                            ),
                            child: Row(
                                children: [
                                  Expanded(
                                      child: Text('ক্যাশ ইজা :',style: StDecoration.boldTextStyle,textAlign: TextAlign.center)
                                  ),
                                  Container(color: Colors.grey,height: 20,width: 0.5),
                                  Expanded(
                                      child: Text('86621/=',style: StDecoration.normalTextStyle,textAlign: TextAlign.center)
                                  )
                                ]
                            )
                        ),
                        SizedBox(height: dynamicSize(.02)),

                        const BlackContainer(title: 'বিক্রয়'),
                        const TableHeaderWidget(title: 'বিল নং', title2: 'চেক নং'),

                        const BlackContainer(title: 'সকল জমা'),
                        const TableHeaderWidget(title: 'ক্যাটাগরি', title2: 'মন্তব্য'),

                        const BlackContainer(title: 'অগ্রিম জমা'),
                        const TableHeaderWidget(title: 'প্রোডাক্ট', title2: 'মন্তব্য'),

                        const TotalWidget(title: 'মোট জমা', amount: '7610823/=')
                      ],
                    ),
                  ),
                  SizedBox(height: dynamicSize(.04)),


                  ///খরচ.................................
                  Container(
                    padding: EdgeInsets.symmetric(vertical: dynamicSize(.03)),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Column(
                      children: [

                        Text('খরচ',style: StDecoration.boldTextStyle,textAlign: TextAlign.center),

                        const BlackContainer(title: 'ক্রয়'),
                        const TableHeaderWidget(title: 'বিল নং', title2: 'চেক নং'),

                        const BlackContainer(title: 'সকল খরচ'),
                        const TableHeaderWidget(title: 'ক্যাটাগরি', title2: 'মন্তব্য'),

                        const TotalWidget(title: 'মোট খরচ', amount: '7610823/=')
                      ],
                    ),
                  ),

                ],
              ),
            ),

            ///Footer...
            if(pc.accountSummery.value.profit!=null
                && pc.accountSummery.value.expense!=null)Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal:dynamicSize(.04),vertical: dynamicSize(.02)),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
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

                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        style: StDecoration.normalTextStyle,
                        children: [
                          const TextSpan(text: 'ক্যাশ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${double.parse(pc.accountSummery.value.profit!.toString())-double.parse(pc.accountSummery.value.expense!.toString())}'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
                ),
          ],
        );
      }
    );
  }

  void _showSearchDialog(PublicController pc){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(dynamicSize(.04)),
          contentPadding: EdgeInsets.all(dynamicSize(.04)),
          title: Text('জমা ও খরচ অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
          content: StatefulBuilder(
              builder: (context,setState) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ///From Date
                      InkWell(
                        onTap: ()async{
                          await _selectFromDate();
                          setState((){});
                        },
                        child: Container(
                          padding: EdgeInsets.all(dynamicSize(.025)),
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
                      SizedBox(height: dynamicSize(.06)),

                      ///To Date
                      InkWell(
                        onTap: ()async{
                          await _selectToDate();
                          setState((){});
                          await PublicController.pc.getAccountSummery(
                            DateFormat('yyyy-MM-dd').format(_fromDate),
                            DateFormat('yyyy-MM-dd').format(_toDate.add(const Duration(days: 1))),
                          );
                          setState((){});
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(dynamicSize(.025)),
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
                      SizedBox(height: dynamicSize(.04)),

                      if(pc.loading.value) const CircularProgressIndicator()
                    ],
                  ),
                );
              }
          ),
        ));
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

