import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  void initState(){
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    if(PublicController.pc.openingBalanceModel.value.data==null){
      await PublicController.pc.getOpeningBalance();
    }
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
            ),
            body: _bodyUI(pc),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>RefreshIndicator(
    onRefresh: ()async=> await pc.getOpeningBalance(),
    backgroundColor: Colors.white,
    child: pc.openingBalanceModel.value.data!=null
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.openingBalanceModel.value.data!.length,
        itemBuilder: (context, index)=> OpeningBalanceTile(model: pc.openingBalanceModel.value.data![index]),
        separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container(),
  );
}
