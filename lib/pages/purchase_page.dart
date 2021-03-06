import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/pdf_helper/purchase_report_pdf.dart';
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
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  CompanyModel? _companyModel;
  Products? _product;
  Supplier? _supplier;
  double _totalQ=0.0, _totalAQ=0.0, _totalUP=0.0, _totalPaid=0.0, _totalDue=0.0;

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.purchaseListModel.value.data==null){
      await PublicController.pc.getAllPurchase();
    }
    if(PublicController.pc.supplierModel.value.data==null
        ||PublicController.pc.supplierModel.value.data!.isEmpty){
      await PublicController.pc.getAllSupplier();
    }
    if(PublicController.pc.productListModel.value.data==null){
      await PublicController.pc.getAllProduct();
    }_totalCount();
  }

  void _totalCount(){
    _totalQ=0.0; _totalAQ=0.0; _totalUP=0.0; _totalPaid=0.0; _totalDue=0.0;
    for(var e in PublicController.pc.purchaseListModel.value.data!){
      if(e.mainQuantity!=null && e.mainQuantity!.isNotEmpty){
        _totalAQ = _totalAQ+double.parse(e.mainQuantity!);
      }if(e.quantity!=null && e.quantity!.isNotEmpty){
        _totalQ = _totalQ+double.parse(e.quantity!);
      }if(e.unitPrice!=null && e.unitPrice!.isNotEmpty){
        _totalUP = _totalUP+double.parse(e.unitPrice!);
      }if(e.paymentAmount!=null && e.paymentAmount!.isNotEmpty){
        _totalPaid = _totalPaid+double.parse(e.paymentAmount!);
      }if(e.due!=null && e.due!.isNotEmpty){
        _totalDue = _totalDue+double.parse(e.paymentAmount!);
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
              title: Text('???????????????', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: (){_showTotalQuantity();}, icon: Icon(LineAwesomeIcons.vertical_ellipsis,size: dynamicSize(.065))),
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getAllPurchase();
                  _totalCount();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
                IconButton(onPressed: (){_showSearchDialog(pc);}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065))),
              ],
            ),
            body: _bodyUI(pc),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
              child: ElevatedButton(
                onPressed: ()async{
                  if(pc.purchaseListModel.value.data!=null && pc.purchaseListModel.value.data!.isNotEmpty){
                    await PurchaseReportPDF.generatePurchasePDFReport(pc.purchaseListModel.value.data!);
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
    onRefresh: ()async{
      await pc.getAllPurchase();
      _totalCount();
    },
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
          title: Text('??????????????? ??????????????????????????? ????????????',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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
                            hint: const Text('???????????????????????? ???????????????????????? ????????????'),
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
                          child: DropdownButton<Products>(
                            value: _product,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('???????????? ???????????????????????? ????????????'),
                            onChanged: (model) {
                              setState(() {_product = model;});
                              setState((){});
                            },
                            items: pc.productListModel.value.data!
                                .map<DropdownMenuItem<Products>>((Products model) {
                              return DropdownMenuItem<Products>(
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
                            hint: const Text('?????????????????????????????? ???????????????????????? ????????????'),
                            onChanged: (model) {
                              setState(() {_supplier = model;});
                              setState((){});
                            },
                            items: pc.supplierModel.value.data!
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
                            'to_date': DateFormat('yyyy-MM-dd').format(_toDate.add(const Duration(days: 1))),
                            'search_company_id': _companyModel!=null? _companyModel!.id!.toString():'',
                            'product_name': _product!=null? _product!.id!.toString():'',
                            'search_supplier_id': _supplier!=null? _supplier!.id!.toString():'',
                          };
                          await pc.searchPurchase(map);
                          _totalCount();
                          setState((){});
                          Get.back();
                        },
                        text: '??????????????????????????? ????????????',
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
    }else{showToast('???????????? ??????????????? ???????????????????????? ????????? ???????????????');}
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
    }else{showToast('???????????? ??????????????? ???????????????????????? ????????? ???????????????');}
  }

  void _showTotalQuantity(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context)=>AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(dynamicSize(.04)),
          contentPadding: EdgeInsets.all(dynamicSize(.04)),
          content: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Quantity:',style: StDecoration.boldTextStyle),
                    Text('${_totalQ.toStringAsFixed(2)} Kg',style: StDecoration.normalTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Available Quantity:',style: StDecoration.boldTextStyle),
                    Text('${_totalAQ.toStringAsFixed(2)} Kg',style: StDecoration.normalTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Unit Price:',style: StDecoration.boldTextStyle),
                    Text('${_totalUP.toStringAsFixed(2)} TK',style: StDecoration.normalTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Paid:',style: StDecoration.boldTextStyle),
                    Text('${_totalPaid.toStringAsFixed(2)} TK',style: StDecoration.normalTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Due:',style: StDecoration.boldTextStyle),
                    Text('${_totalDue.toStringAsFixed(2)} TK',style: StDecoration.normalTextStyle)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
