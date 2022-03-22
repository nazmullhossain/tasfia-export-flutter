import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/pages/employee_page.dart';
import 'package:tashfia_export/pages/expense_list_page.dart';
import 'package:tashfia_export/pages/product_page.dart';
import 'package:tashfia_export/pages/purchase_page.dart';
import 'package:tashfia_export/pages/opening_balance_page.dart';
import 'package:tashfia_export/pages/report/report_page.dart';
import 'package:tashfia_export/pages/sell_page.dart';
import 'package:tashfia_export/pages/stock_list_page.dart';
import 'package:tashfia_export/pages/supplier_list_page.dart';
import 'package:tashfia_export/pages/customer_list_page.dart';
import 'package:tashfia_export/pages/dashboard_page.dart';
import '../../variables/config.dart';
import '../controller/public_controller.dart';
import '../model/home_menu_model.dart';


class HomeMenuTile extends StatelessWidget {
  const HomeMenuTile({Key? key, required this.model}) : super(key: key);
  final HomeMenuModel model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return  InkWell(
            onTap: ()async{
              if(model.title=='ড্যাশবোর্ড') {
                Get.to(()=> const DashboardPage());
              } else if(model.title=='ক্রেতা') {
                Get.to(()=> const AllCustomerPage());
              }else if(model.title=='সরবরাহকারী') {
                Get.to(()=> const SupplierListPage());
              }else if(model.title=='রিপোর্ট') {
                Get.to(()=> const ReportPage());
              }else if(model.title=='সকল কর্মচারী') {
                Get.to(()=> const AllEmployeePage());
              }else if(model.title=='পণ্য') {
                Get.to(()=> const AllProductPage());
              }else if(model.title=='ক্রয়') {
                Get.to(()=> const AllPurchasePage());
              }else if(model.title=='ওপেনিং ব্যালেন্স') {
                Get.to(()=> const OpeningBalancePage());
              }else if(model.title=='বিক্রয়') {
                Get.to(()=> const SellPage());
              }else if(model.title=='স্টক') {
                Get.to(()=> const StockListPage());
              }else if(model.title=='খরচ হিসাব') {
                Get.to(()=> const ExpenseListPage());
              }else if(model.title=='লগ আউট') {
                await pc.logout();
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(dynamicSize(.04)),
              decoration: BoxDecoration(
                  color: model.color.withOpacity(.15),
                  borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.05)))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(model.icon,color: model.color,size: dynamicSize(.12)),
                    backgroundColor: Colors.white,
                    radius: dynamicSize(.09),
                  ),
                  SizedBox(height: dynamicSize(.02)),
                  Text(model.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontSize: dynamicSize(.045)
                          ,fontWeight: FontWeight.w600))
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.05)))
        );
      }
    );
  }
}
