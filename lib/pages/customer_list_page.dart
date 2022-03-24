import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/util/customer_list_tile.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:tashfia_export/variables/variable.dart';
import 'package:tashfia_export/widgets/color_button.dart';
import 'package:tashfia_export/widgets/text_field_tile.dart';
import '../model/company_list_model.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../widgets/loading_widget.dart';

class AllCustomerPage extends StatefulWidget {
  const AllCustomerPage({Key? key}) : super(key: key);

  @override
  State<AllCustomerPage> createState() => _AllCustomerPageState();
}

class _AllCustomerPageState extends State<AllCustomerPage> {

  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');
  final TextEditingController _customerId = TextEditingController(text: '');
  CompanyModel? _companyModel;

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.customerModel.value.customers==null
        ||PublicController.pc.customerModel.value.customers!.isEmpty){
      await PublicController.pc.getAllCustomer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('ক্রেতা', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getAllCustomer();
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
    onRefresh: ()async=> await pc.getAllCustomer(),
    backgroundColor: Colors.white,
    child: pc.customerModel.value.customers!=null
        ?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.customerModel.value.customers!.length,
        itemBuilder: (context, index)=> CustomerListTile(model: pc.customerModel.value.customers![index]),
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
          title: Text('ক্রেতা অনুসন্ধান করুন',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
          content: StatefulBuilder(
            builder: (context,setState) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [

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

                    TextFieldTile(controller:  _name, labelText: 'নাম',textCapitalization: TextCapitalization.words),
                    SizedBox(height: dynamicSize(.06)),
                    TextFieldTile(controller:  _phone, labelText: 'ফোন নাম্বার',textInputType: TextInputType.number),
                    SizedBox(height: dynamicSize(.06)),
                    TextFieldTile(controller:  _customerId, labelText: 'ক্রেতার আইডি'),
                    SizedBox(height: dynamicSize(.06)),

                    !pc.loading.value
                        ?ColorTextButton(
                        onPressed: ()async{
                          if(_phone.text.isNotEmpty || _name.text.isNotEmpty || _companyModel!=null || _customerId.text.isNotEmpty){
                            setState((){});
                            Map<String,String> map = {
                              'name':_name.text,
                              'phone': _phone.text,
                              'company_name': _companyModel!=null?_companyModel!.id.toString():'',
                              'customer_id': _customerId.text
                            };
                            await pc.searchCustomer(map);
                            setState((){});
                            Get.back();
                          }else{showToast('ফিল্ড পূরন করুন');}
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
}

