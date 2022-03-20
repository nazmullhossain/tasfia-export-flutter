import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/pages/all_employee_page.dart';
import 'package:tashfia_export/pages/all_product_page.dart';
import 'package:tashfia_export/pages/all_purchase_page.dart';
import 'package:tashfia_export/pages/report/report_page.dart';
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
            onTap: (){
              if(model.title=='Dashboard') {
                Get.to(()=> const DashboardPage());
              } else if(model.title=='Customer') {
                Get.to(()=> const AllCustomerPage());
              }else if(model.title=='Supplier') {
                Get.to(()=> const SupplierListPage());
              }else if(model.title=='Report') {
                Get.to(()=> const ReportPage());
              }else if(model.title=='All Employee') {
                Get.to(()=> const AllEmployeePage());
              }else if(model.title=='Products') {
                Get.to(()=> const AllProductPage());
              }else if(model.title=='Purchase') {
                Get.to(()=> const AllPurchasePage());
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
