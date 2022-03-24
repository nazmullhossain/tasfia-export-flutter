import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/widgets/text_field_tile.dart';
import '../controller/public_controller.dart';
import '../controller/pdf_helper/sales_report_pdf.dart';
import '../model/company_list_model.dart';
import '../util/decoration.dart';
import '../util/purchase_list_tile.dart';
import '../util/sales_list_tile.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/color_button.dart';
import '../widgets/loading_widget.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  CompanyModel? _companyModel;
  Customer? _customer;
  String? _paymentStatus;
  final TextEditingController _invoiceNumber = TextEditingController(text: '');
  double _totalA=0.0, _totalPA=0.0, _totalDue=0.0;

  @override
  void initState(){
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    if(PublicController.pc.sellModel.value.data==null
    || PublicController.pc.sellModel.value.data!.isEmpty){
      await PublicController.pc.getSellList();
    }
    if(PublicController.pc.customerModel.value.customers==null
        || PublicController.pc.customerModel.value.customers!.isEmpty){
      await PublicController.pc.getAllCustomer();
    }
    if(PublicController.pc.companyModel.value.data==null
        ||PublicController.pc.companyModel.value.data!.isEmpty){
      await PublicController.pc.getCompanyList();
    }_totalCount();
  }

  void _totalCount(){
    _totalA=0.0; _totalPA=0.0; _totalDue=0.0;
    for(var e in PublicController.pc.sellModel.value.data!){
      if(e.totalPrice!=null && e.totalPrice!.isNotEmpty){
        _totalA = _totalA+double.parse(e.totalPrice!);
      }if(e.paymentAmount!=null && e.paymentAmount!.isNotEmpty) {
        _totalPA = _totalPA + double.parse(e.paymentAmount!);
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
              title: Text('বিক্রয়', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: (){_showTotalQuantity();}, icon: Icon(LineAwesomeIcons.vertical_ellipsis,size: dynamicSize(.065))),
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getSellList();
                  _totalCount();
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
                  if(pc.sellModel.value.data!=null && pc.sellModel.value.data!.isNotEmpty){
                    await SalesReportPDF.generateSalesPDFReport(pc.sellModel.value.data!);
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
      await pc.getSellList();
      _totalCount();
    },
    backgroundColor: Colors.white,
    child: pc.sellModel.value.data!=null && pc.sellModel.value.data!.isNotEmpty
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.sellModel.value.data!.length,
        itemBuilder: (context, index)=> SalesListTile(model: pc.sellModel.value.data![index]),
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
          title: Text('বিক্রয় অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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

                      ///Customer Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Customer>(
                            value: _customer,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('কাস্টমার নির্বাচন করুন'),
                            onChanged: (model) {
                              setState(() {_customer = model;});
                              setState((){});
                            },
                            items: pc.customerModel.value.customers!
                                .map<DropdownMenuItem<Customer>>((Customer model) {
                              return DropdownMenuItem<Customer>(
                                value: model,
                                child: Text(model.name!,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      ///Payment status Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _paymentStatus,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('পেমেন্ট স্ট্যাটাস'),
                            onChanged: (newVal) {
                              setState(() {_paymentStatus = newVal;});
                              setState((){});
                            },
                            items: Variables.paymentStatusList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      TextFieldTile(controller: _invoiceNumber, hintText: 'ইনভয়েজ নাম্বার'),
                      SizedBox(height: dynamicSize(.06)),

                      !pc.loading.value
                          ?ColorTextButton(
                        onPressed: ()async{
                          setState((){});
                          Map<String,String> map = {
                            'from_date': DateFormat('yyyy-MM-dd').format(_fromDate),
                            'to_date': DateFormat('yyyy-MM-dd').format(_toDate),
                            'search_company_id': _companyModel!=null? _companyModel!.id!.toString():'',
                            'search_payment_status': _paymentStatus??'',
                            'search_customer_id': _customer!=null? _customer!.id!.toString():'',
                            'invoice_number': _invoiceNumber.text,
                          };
                          await pc.searchSellList(map);
                          _totalCount();
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
                    Text('Total Amount:',style: StDecoration.boldTextStyle),
                    Text('${_totalA.toStringAsFixed(2)} TK',style: StDecoration.normalTextStyle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Paid Amount:',style: StDecoration.boldTextStyle),
                    Text('${_totalPA.toStringAsFixed(2)} TK',style: StDecoration.normalTextStyle)
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
