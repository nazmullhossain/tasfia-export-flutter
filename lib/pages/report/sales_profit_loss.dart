import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/variables/color_variable.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';
import '../../variables/variable.dart';

class SalesProfitLoss extends StatefulWidget {
  const SalesProfitLoss({Key? key}) : super(key: key);

  @override
  State<SalesProfitLoss> createState() => _SalesProfitLossState();
}

class _SalesProfitLossState extends State<SalesProfitLoss> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
        builder: (pc) {
          return Column(
            children: [
              ///Search Container
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
                              Text('From Date: ',style: StDecoration.boldTextStyle),
                              Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_fromDate),style: StDecoration.normalTextStyle)),
                              Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                            ],
                          ),
                        ),
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                      ),
                      SizedBox(height: dynamicSize(.05)),
                      InkWell(
                        onTap: ()async{
                          await _selectToDate();
                        },
                        child: Container(
                          padding: EdgeInsets.all(dynamicSize(.02)),
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
                    ],
                  ),
                ),
              ),

              ///Data List
              Expanded(
                child: ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
                  itemCount: 20,
                  separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04)),
                  itemBuilder: (context, index)=>Container(
                    padding: EdgeInsets.all(dynamicSize(.02)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.02))),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: StDecoration.normalTextStyle,
                        children: [
                          const TextSpan(text: 'SL: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '$index\n'),
                          const TextSpan(text: 'Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(DateTime.now())}\n'),
                          const TextSpan(text: 'Customer Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'Rakib $index\n'),
                          const TextSpan(text: 'Sales Amount: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${12*index}\n'),
                          const TextSpan(text: 'Profit/loss: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${index+5}'),
                        ],
                      ),
                    ),
                  ),
                  ),
              ),

              ///Bottom Container
              Container(
                padding: EdgeInsets.symmetric(vertical: dynamicSize(.02),horizontal: dynamicSize(.05)),
                decoration: BoxDecoration(
                    color: AllColor.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(dynamicSize(.03)),
                      topRight: Radius.circular(dynamicSize(.03))
                    ),
                ),
                child: Row(
                  children: [
                    Text('Total:',style: StDecoration.boldTextStyle.copyWith(color:Colors.white)),
                    Expanded(child: Text('(1211000)',textAlign: TextAlign.end,
                        style: StDecoration.boldTextStyle.copyWith(color:Colors.white)))
                  ],
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
