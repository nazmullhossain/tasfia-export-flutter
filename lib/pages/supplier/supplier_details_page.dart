import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/pages/supplier/purchase_history_supplier.dart';
import '../../controller/public_controller.dart';
import '../../util/decoration.dart';
import '../../variables/color_variable.dart';
import '../../variables/config.dart';
import '../../widgets/loading_widget.dart';
import 'due_payment_history_supplier.dart';

class SupplierDetailsPage extends StatefulWidget {
  const SupplierDetailsPage({Key? key,required this.model}) : super(key: key);
  final Supplier model;

  @override
  State<SupplierDetailsPage> createState() => _SupplierDetailsPageState();
}

class _SupplierDetailsPageState extends State<SupplierDetailsPage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator:const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 3.5, color: AllColor.primaryColor))),
                        tabs: [
                          Tab(child: Text('ক্রয় বিবরণ',style: StDecoration.boldTextStyle.copyWith(fontSize: dynamicSize(.046)))),
                          Tab(child: Text('পূর্ববর্তী বকেয়া পেমেন্ট বিবরণ',style: StDecoration.boldTextStyle))
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
                PurchaseHistorySupplier(model: widget.model),
                DuePaymentHistorySupplier(model: widget.model)
              ],
            ),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }
}