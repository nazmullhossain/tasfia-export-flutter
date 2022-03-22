import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/category_list_model.dart';
import 'package:tashfia_export/util/expense_list_tile.dart';

import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../variables/variable.dart';
import '../widgets/color_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_tile.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({Key? key}) : super(key: key);

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 1));
  DateTime _toDate = DateTime.now();
  CategoryModel? _categoryModel;
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _amount = TextEditingController(text: '');

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.expenseModel.value.data==null
        ||PublicController.pc.expenseModel.value.data!.isEmpty){
      PublicController.pc.getExpenseList();
    }
    if(PublicController.pc.categoryModel.value.data==null
        ||PublicController.pc.categoryModel.value.data!.isEmpty){
      await PublicController.pc.getCategoryList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('খরচ হিসাব', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getExpenseList();
                  pc.loading(false);pc.update();
                }, icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
                IconButton(onPressed: (){_showSearchDialog(pc);}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065)))
              ],
            ),
            body: _bodyUI(pc),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>RefreshIndicator(
    onRefresh: ()async=> await pc.getExpenseList(),
    backgroundColor: Colors.white,
    child: pc.expenseModel.value.data!=null
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.expenseModel.value.data!.length,
        itemBuilder: (context, index)=> ExpenseListTile(model: pc.expenseModel.value.data![index],index: index),
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
          title: Text('খরচ হিসাব অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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

                      ///Category Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.025)),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.blueGrey,width: .5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CategoryModel>(
                            value: _categoryModel,
                            icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                            elevation: 16,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            isDense: true,
                            hint: const Text('ক্যাটাগরী নির্বাচন করুন'),
                            onChanged: (model) {
                              setState(() {_categoryModel = model;});
                              setState((){});
                            },
                            items: pc.categoryModel.value.data!
                                .map<DropdownMenuItem<CategoryModel>>((CategoryModel model) {
                              return DropdownMenuItem<CategoryModel>(
                                value: model,
                                child: Text(model.name!,style: StDecoration.normalTextStyle),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: dynamicSize(.06)),

                      TextFieldTile(controller: _name,hintText: 'নাম', textCapitalization: TextCapitalization.words),
                      SizedBox(height: dynamicSize(.06)),

                      TextFieldTile(controller: _amount,hintText: 'পরিমান',textInputType: TextInputType.number),
                      SizedBox(height: dynamicSize(.06)),

                      !pc.loading.value
                          ?ColorTextButton(
                        onPressed: ()async{
                          setState((){});
                          Map<String,String> map = {
                            'from_date': DateFormat('yyyy-MM-dd').format(_fromDate),
                            'to_date': DateFormat('yyyy-MM-dd').format(_toDate),
                            'search_amount': _amount.text,
                            'search_name': _name.text,
                            'expenses_category': _categoryModel!=null? _categoryModel!.id!.toString():'',
                          };
                          await pc.searchExpenseList(map);
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
