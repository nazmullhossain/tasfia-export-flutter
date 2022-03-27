import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/util/advance_sale_tile.dart';
import '../controller/public_controller.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/loading_widget.dart';

class AdvanceSalePage extends StatefulWidget {
  const AdvanceSalePage({Key? key}) : super(key: key);

  @override
  State<AdvanceSalePage> createState() => _AdvanceSalePageState();
}

class _AdvanceSalePageState extends State<AdvanceSalePage> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.advanceSaleModel.value.data==null){
      await PublicController.pc.getAdvanceSaleList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('মোট অগ্রিম বিক্রয়', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getAdvanceSaleList();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),

                IconButton(onPressed: (){_showSearchDialog(pc);}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065)))
              ],
            ),
            body: _bodyUI(pc),
            bottomNavigationBar: Container(
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
                  Text('মোট অগ্রিম বিক্রয়:',style: StDecoration.boldTextStyle.copyWith(color:Colors.white)),
                  Expanded(child: Text('${pc.advanceSaleModel.value.data!=null? pc.advanceSaleModel.value.data!.length:''}',textAlign: TextAlign.end,
                      style: StDecoration.boldTextStyle.copyWith(color:Colors.white)))
                ],
              ),
            ),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>RefreshIndicator(
    onRefresh: ()async=>await pc.getAllEmployee(),
    backgroundColor: Colors.white,
    child: pc.advanceSaleModel.value.data!=null?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.advanceSaleModel.value.data!.length,
        itemBuilder: (context, index)=> AdvanceSaleTile(model: pc.advanceSaleModel.value.data![index]),
        separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container(),
  );

  void _showSearchDialog(PublicController pc){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(dynamicSize(.04)),
          contentPadding: EdgeInsets.all(dynamicSize(.04)),
          title: Text('অগ্রিম বিক্রয় অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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
                          await pc.searchAdvanceSaleList(DateFormat('yyyy-MM-dd').format(_fromDate),
                              DateFormat('yyyy-MM-dd').format(_toDate));
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
