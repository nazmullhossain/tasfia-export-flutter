import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/util/stock_list_tile.dart';
import 'package:tashfia_export/widgets/text_field_tile.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/color_button.dart';
import '../widgets/loading_widget.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({Key? key}) : super(key: key);

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {

  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime _toDate = DateTime.now();
  Supplier? _supplier;
  final TextEditingController _productName = TextEditingController(text: '');
  double _totalMainQuantity = 0.0;

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.stockModel.value.data==null
        ||PublicController.pc.stockModel.value.data!.isEmpty){
      PublicController.pc.getStockList();
    }
    if(PublicController.pc.supplierModel.value.suppliers==null
        ||PublicController.pc.supplierModel.value.suppliers!.isEmpty){
      await PublicController.pc.getAllSupplier();
    }_totalQuantityCount();
  }

  void _totalQuantityCount(){
    _totalMainQuantity = 0.0;
    for(var e in PublicController.pc.stockModel.value.data!){
      if(e.mainQuantity!=null && e.mainQuantity!.isNotEmpty){
        _totalMainQuantity = _totalMainQuantity+ double.parse(e.mainQuantity!);
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
              title: Text('স্টক (মোটঃ ${pc.stockModel.value.data!=null?pc.stockModel.value.data!.length:0})', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getStockList();
                  _totalQuantityCount();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
                IconButton(onPressed: (){_showSearchDialog(pc);}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065)))
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
                  Text('মোট লভ্য পরিমান:',style: StDecoration.boldTextStyle.copyWith(color:Colors.white)),
                  Expanded(child: Text('(${_totalMainQuantity.toStringAsFixed(2)}) TK',textAlign: TextAlign.end,
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
      await pc.getStockList();
      _totalQuantityCount();
    } ,
    backgroundColor: Colors.white,
    child: pc.stockModel.value.data!=null
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.stockModel.value.data!.length,
        itemBuilder: (context, index)=> StockListTile(model: pc.stockModel.value.data![index]),
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
          title: Text('স্টক অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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

                      TextFieldTile(controller: _productName,hintText: 'পণ্যের নাম'),
                      SizedBox(height: dynamicSize(.06)),

                      !pc.loading.value
                          ?ColorTextButton(
                        onPressed: ()async{
                          setState((){});
                          Map<String,String> map = {
                            'from_date': DateFormat('yyyy-MM-dd').format(_fromDate),
                            'to_date': DateFormat('yyyy-MM-dd').format(_toDate),
                            'product_name': _productName.text,
                            'search_supplier_id': _supplier!=null? _supplier!.id!.toString():'',
                          };
                          await pc.searchStockList(map);
                          _totalQuantityCount();
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
