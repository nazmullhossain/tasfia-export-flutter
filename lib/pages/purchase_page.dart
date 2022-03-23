import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/purchase_report_pdf.dart';
import 'package:tashfia_export/model/product_list_model.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/util/purchase_list_tile.dart';
import '../controller/public_controller.dart';
import '../model/company_list_model.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/color_button.dart';
import '../widgets/loading_widget.dart';

class AllPurchasePage extends StatefulWidget {
  const AllPurchasePage({Key? key}) : super(key: key);

  @override
  State<AllPurchasePage> createState() => _AllPurchasePageState();
}

class _AllPurchasePageState extends State<AllPurchasePage> {
  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime _toDate = DateTime.now();
  CompanyModel? _companyModel;
  Product? _product;
  Supplier? _supplier;

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.purchaseListModel.value.data==null){
      await PublicController.pc.getAllPurchase();
    }
    if(PublicController.pc.supplierModel.value.suppliers==null
        ||PublicController.pc.supplierModel.value.suppliers!.isEmpty){
      await PublicController.pc.getAllSupplier();
    }
    if(PublicController.pc.productListModel.value.data==null){
      await PublicController.pc.getAllProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('ক্রয়', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getAllPurchase();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
                IconButton(onPressed: (){_showSearchDialog(pc);}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065)))
              ],
            ),
            body: _bodyUI(pc),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
              child: ElevatedButton(
                onPressed: ()async{
                  if(pc.purchaseListModel.value.data!=null && pc.purchaseListModel.value.data!.isNotEmpty){
                    PurchaseReportPDF.generatePurchasePDFReport(pc.purchaseListModel.value.data!);
                  }else{showToast('Empty Data');}
                },
                child: Text('Print Report',style: StDecoration.boldTextStyle.copyWith(color: Colors.white)),
              ),
            ),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>RefreshIndicator(
    onRefresh: ()async=> await pc.getAllProduct(),
    backgroundColor: Colors.white,
    child: pc.purchaseListModel.value.data!=null && pc.purchaseListModel.value.data!.isNotEmpty
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.purchaseListModel.value.data!.length,
        itemBuilder: (context, index)=> PurchaseListTile(model: pc.purchaseListModel.value.data![index]),
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
          title: Text('ক্রয় অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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
                              Text('তারিখ হইতে: ',style: StDecoration.boldTextStyle),
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
                        },
                        child: Container(
                          padding: EdgeInsets.all(dynamicSize(.025)),
                          decoration: BoxDecoration(
                              borderRadius:const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.blueGrey, width: 0.5)
                          ),
                          child: Row(
                            children: [
                              Text('এখন পর্যন্ত: ',style: StDecoration.boldTextStyle),
                              Expanded(child: Text(DateFormat('dd-MMM-yyyy').format(_toDate),style: StDecoration.normalTextStyle)),
                              Icon(LineAwesomeIcons.calendar,size: dynamicSize(.07))
                            ],
                          ),
                        ),
                        borderRadius:const BorderRadius.all(Radius.circular(5)),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      ///Company Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CompanyModel>(
                            value: _companyModel,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('কোম্পানি নির্বাচন করুন'),
                            onChanged: (model) {
                              setState(() {_companyModel = model;});
                              setState((){});
                            },
                            items: pc.companyModel.value.data!
                                .map<DropdownMenuItem<CompanyModel>>((CompanyModel model) {
                              return DropdownMenuItem<CompanyModel>(
                                value: model,
                                child: Text(model.companyName!,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      ///Product Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Product>(
                            value: _product,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('পণ্য নির্বাচন করুন'),
                            onChanged: (model) {
                              setState(() {_product = model;});
                              setState((){});
                            },
                            items: pc.productListModel.value.data!
                                .map<DropdownMenuItem<Product>>((Product model) {
                              return DropdownMenuItem<Product>(
                                value: model,
                                child: Text(model.chalanNo!,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      ///Supplier Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Supplier>(
                            value: _supplier,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('সরবরাহকারী নির্বাচন করুন'),
                            onChanged: (model) {
                              setState(() {_supplier = model;});
                              setState((){});
                            },
                            items: pc.supplierModel.value.suppliers!
                                .map<DropdownMenuItem<Supplier>>((Supplier model) {
                              return DropdownMenuItem<Supplier>(
                                value: model,
                                child: Text(model.name!,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      !pc.loading.value
                          ?ColorTextButton(
                        onPressed: ()async{
                          setState((){});
                          Map<String,String> map = {
                            'from_date': DateFormat('yyyy-MM-dd').format(_fromDate),
                            'to_date': DateFormat('yyyy-MM-dd').format(_toDate),
                            'search_company_id': _companyModel!=null? _companyModel!.id!.toString():'',
                            'product_name': _product!=null? _product!.id!.toString():'',
                            'search_supplier_id': _supplier!=null? _supplier!.id!.toString():'',
                          };
                          await pc.searchPurchase(map);
                          setState((){});
                          Get.back();
                        },
                        text: 'অনুসন্ধান করুন',
                        minimumSize: Size(dynamicSize(.45),dynamicSize(.1)),
                      ):const CircularProgressIndicator()
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
