import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/loss_pfofit_pdf.dart';
import 'package:tashfia_export/variables/color_variable.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/config.dart';
import '../../variables/variable.dart';

class SalesProfitLoss extends StatefulWidget {
  const SalesProfitLoss({Key? key,required this.profitLoss}) : super(key: key);
  final bool profitLoss;

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
                  child: Row(
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
                            SizedBox(height: dynamicSize(.05)),
                            InkWell(
                              onTap: ()async{
                                await _selectToDate();
                                await pc.searchSalesProfitLoss(DateFormat('yyyy-MM-dd').format(_fromDate),
                                    DateFormat('yyyy-MM-dd').format(_toDate));
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
                            if(pc.salesProfitLossModel.value.data!=null
                                && pc.salesProfitLossModel.value.data!.isNotEmpty){
                              await LossProfitPDF.generateSalesProfitLossPDFReport(pc.salesProfitLossModel.value.data!);
                            }else{showToast('Empty Data');}
                          },
                          child: Text('Print',style: StDecoration.boldTextStyle.copyWith(color: Colors.white)))
                    ],
                  ),
                ),
              ),

              ///Data List
              Expanded(
                child:pc.salesProfitLossModel.value.data!=null
                    && pc.salesProfitLossModel.value.data!.isNotEmpty
                    ? ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
                  itemCount: pc.salesProfitLossModel.value.data!.length,
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
                          TextSpan(text: '${index+1}\n'),
                          const TextSpan(text: 'তারিখ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${DateFormat('dd-MMM-yyyy').format(DateTime.now())}\n'),
                          const TextSpan(text: 'ক্রেতার নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${pc.salesProfitLossModel.value.data![index].customer!.name}\n'),
                          const TextSpan(text: 'বিক্রয় পরিমাণ: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${pc.salesProfitLossModel.value.data![index].totalPrice}\n'),
                          const TextSpan(text: 'লাভ/ক্ষতি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: pc.salesProfitLossModel.value.data![index].profitOrLoss??''),
                        ],
                      ),
                    ),
                  ),
                  ):Container(),
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
                    Text('মোট:',style: StDecoration.boldTextStyle.copyWith(color:Colors.white)),
                    Expanded(child: Text('(${double.parse((pc.salesProfitLossModel.value.profitOrLoss).toStringAsFixed(2))}) TK',textAlign: TextAlign.end,
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
