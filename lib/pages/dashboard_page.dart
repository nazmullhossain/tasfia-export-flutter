import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/home_menu_model.dart';
import 'package:tashfia_export/util/dashboard_tile.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/util/five_transaction_tile.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:tashfia_export/widgets/loading_widget.dart';
import '../variables/color_variable.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<HomeMenuModel> _dashboardDataList = HomeMenuModel.dashboardDataList;

  @override
  void initState() {
    super.initState();
    _initData(PublicController.pc);
  }

  Future<void> _initData(PublicController pc) async {
    if (PublicController.pc.customerModel.value.data == null ||
        PublicController.pc.customerModel.value.data!.isEmpty) {
      await PublicController.pc.getAllCustomer();
    }
    if (PublicController.pc.supplierModel.value.data == null ||
        PublicController.pc.supplierModel.value.data!.isEmpty) {
      await PublicController.pc.getAllSupplier();
    }
    _dashboardDataList = [
      HomeMenuModel(
          title:
              'আজকের মোট বিক্রয়\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.todayTotalSalesQuantity}কেজি/${pc.dashboardModel.value.todaySalesAmount}টাকা',
          icon: LineAwesomeIcons.dollar_sign,
          color: const Color(0xff007BFF)),
      HomeMenuModel(
          title:
              'বর্তমান মাসের মোট বিক্রয়\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.currentMonthTotalSalesQuantity}কেজি/${pc.dashboardModel.value.currentMonthSalesAmount}টাকা',
          icon: LineAwesomeIcons.dollar_sign,
          color: const Color(0xff11CDEF)),
      HomeMenuModel(
          title:
              'আজকের মোট ক্রয়\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.todayPurchaseQuantity}কেজি/${pc.dashboardModel.value.todayPurchaseAmount}টাকা',
          icon: LineAwesomeIcons.shopping_cart,
          color: const Color(0xff2DCE89)),
      HomeMenuModel(
          title:
              'বর্তমান মাসের মোট ক্রয়\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.currentMonthPurchaseQuantity}কেজি/${pc.dashboardModel.value.currentMonthPurchaseAmount}টাকা',
          icon: LineAwesomeIcons.shopping_cart,
          color: const Color(0xff343A40)),
      HomeMenuModel(
          title:
              'আজকের মোট বকেয়া\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.todayDueQuantity}কেজি/${pc.dashboardModel.value.todayDueAmount}টাকা',
          icon: LineAwesomeIcons.dollar_sign,
          color: const Color(0xffDF2DE3)),
      HomeMenuModel(
          title:
              'বর্তমান মাসের মোট পাওনা\n(পরিমাণ/অর্থ)\n${pc.dashboardModel.value.currentMonthDueQuantity}কেজি/${pc.dashboardModel.value.currentMonthDueAmount}টাকা',
          icon: LineAwesomeIcons.dollar_sign,
          color: const Color(0xffFB6340)),
      HomeMenuModel(
          title: 'মোট কাস্টমার\n${pc.dashboardModel.value.totalCusdtomer}',
          icon: LineAwesomeIcons.users,
          color: const Color(0xffF5365C)),
      HomeMenuModel(
          title: 'মোট সাপ্লায়ার\n${pc.dashboardModel.value.totalSupplier}',
          icon: LineAwesomeIcons.user_plus,
          color: const Color(0xffCAD900))
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc) {
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('ড্যাশবোর্ড', style: StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
            ),
            body: _bodyUI(pc),
          ),
          if (pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc) => ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: dynamicSize(.04), vertical: dynamicSize(.02)),
              itemCount: _dashboardDataList.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: dynamicSize(.04)),
              itemBuilder: (context, index) =>
                  DashboardTile(model: _dashboardDataList[index])),
          SizedBox(height: dynamicSize(.04)),

          ///Last 5 Transaction
          Container(
            padding: EdgeInsets.all(dynamicSize(.04)),
            margin: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header
                Row(
                  children: [
                    Expanded(
                        child: Text('শেষ ৫টি লেনদেন',
                            style: StDecoration.boldTextStyle
                                .copyWith(fontSize: dynamicSize(.05)))),
                    Icon(LineAwesomeIcons.angle_down, size: dynamicSize(.06))
                  ],
                ),
                const Divider(color: Colors.blueGrey, thickness: 1),

                ///Transaction List
                pc.fiveTransactionModel.value.data != null
                    ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: pc.fiveTransactionModel.value.data!.length,
                        separatorBuilder: (context, index) => const Divider(
                            color: Colors.blueGrey, thickness: .5),
                        itemBuilder: (context, index) => FiveTransactionTile(
                            model: pc.fiveTransactionModel.value.data![index]))
                    : Container()
              ],
            ),
          ),
          SizedBox(height: dynamicSize(.04)),
        ],
      );
}
