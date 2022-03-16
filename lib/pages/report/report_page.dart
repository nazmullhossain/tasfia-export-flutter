import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/pages/report/deposite_expenses.dart';
import 'package:tashfia_export/pages/report/sales_profit_loss.dart';
import 'package:tashfia_export/variables/config.dart';
import '../../util/decoration.dart';
import '../../widgets/loading_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  final DateTime _fromDate = DateTime.now();
  final DateTime _toDate = DateTime.now();
  bool _gotAllData=false;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initData();
  }

  Future<void> _initData()async{
    await Future.delayed(const Duration(milliseconds: 1));
    await PublicController.pc.getAccountSummery(
        '${_fromDate.year}-${_fromDate.month}-${_fromDate.day}',
        '${_toDate.year}-${_toDate.month}-${_toDate.day}');
    setState(()=>_gotAllData=true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(dynamicSize(15)),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back,size: dynamicSize(.07))),
                    Expanded(
                      child: TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(child: Text('জমা এবং খরচ',style: StDecoration.boldTextStyle.copyWith(fontSize: dynamicSize(.046)))),
                          Tab(child: Text('Sales profit loss',style: StDecoration.boldTextStyle)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics:const BouncingScrollPhysics(),
              children: [
                DepositExpenses(gotAllData: _gotAllData),
                const SalesProfitLoss()
              ],
            ),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }
}
