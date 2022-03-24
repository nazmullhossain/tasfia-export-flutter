import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/util/opening_balance_tile.dart';
import '../controller/public_controller.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../widgets/loading_widget.dart';

class OpeningBalancePage extends StatefulWidget {
  const OpeningBalancePage({Key? key}) : super(key: key);

  @override
  State<OpeningBalancePage> createState() => _OpeningBalancePageState();
}

class _OpeningBalancePageState extends State<OpeningBalancePage> {
  double _totalOpeningBal=0.0;
  @override
  void initState(){
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    if(PublicController.pc.openingBalanceModel.value.data==null){
      await PublicController.pc.getOpeningBalance();
    }_totalOpeningBalanceCount();
  }
  void _totalOpeningBalanceCount(){
    _totalOpeningBal = 0.0;
    for(var e in PublicController.pc.openingBalanceModel.value.data!){
      if(e.openingBalance!=null && e.openingBalance!.isNotEmpty){
        _totalOpeningBal = _totalOpeningBal+ double.parse(e.openingBalance!);
      }
    }setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('ওপেনিং এবং ক্লোজিং ব্যালেন্স', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getOpeningBalance();
                  _totalOpeningBalanceCount();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
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
                  Text('মোট ওপেনিং ব্যাল্যান্স:',style: StDecoration.boldTextStyle.copyWith(color:Colors.white)),
                  Expanded(child: Text('(${_totalOpeningBal.toStringAsFixed(2)}) TK',textAlign: TextAlign.end,
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
    onRefresh: ()async{
      await pc.getOpeningBalance();
      _totalOpeningBalanceCount();
    },
    backgroundColor: Colors.white,
    child: pc.openingBalanceModel.value.data!=null
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.openingBalanceModel.value.data!.length,
        itemBuilder: (context, index)=> OpeningBalanceTile(model: pc.openingBalanceModel.value.data![index], index: index),
        separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container(),
  );
}
