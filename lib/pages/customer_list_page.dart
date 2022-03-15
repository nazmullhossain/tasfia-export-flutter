import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/util/customer_list_tile.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:tashfia_export/widgets/color_button.dart';
import 'package:tashfia_export/widgets/text_field_tile.dart';
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
  String? _company;

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
              title: Text('Customers', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: (){_showSearchDialog();}, icon: Icon(LineAwesomeIcons.search,size: dynamicSize(.065)))
              ],
            ),
            body: _bodyUI(pc),
          ),
          if(pc.loading.value) const LoadingWidget()
        ],
      );
    });
  }

  Widget _bodyUI(PublicController pc)=>ListView.separated(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
    itemCount: pc.customerModel.value.customers!.length,
    itemBuilder: (context, index)=> CustomerListTile(model: pc.customerModel.value.customers![index]),
    separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04)));

  void _showSearchDialog(){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(dynamicSize(.04)),
          contentPadding: EdgeInsets.all(dynamicSize(.04)),
          title: Text('Search customer',textAlign: TextAlign.center,style: StDecoration.boldTextStyle),
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
                        child: DropdownButton<String>(
                          value: _company,
                          icon: Icon(LineAwesomeIcons.angle_down,size: dynamicSize(.04)),
                          elevation: 16,
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          isDense: true,
                          hint: const Text('Select Company'),
                          onChanged: (String? newValue) {
                            setState(() {_company = newValue!;});
                            setState((){});
                          },
                          items: <String>['One', 'Two', 'Free', 'Four']
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

                    TextFieldTile(controller:  _name, labelText: 'Name'),
                    SizedBox(height: dynamicSize(.06)),
                    TextFieldTile(controller:  _phone, labelText: 'Phone Number'),
                    SizedBox(height: dynamicSize(.06)),
                    TextFieldTile(controller:  _customerId, labelText: 'Customer ID'),
                    SizedBox(height: dynamicSize(.06)),

                    ColorTextButton(
                        onPressed: (){},
                        text: 'Search',
                       minimumSize: Size(dynamicSize(.45),dynamicSize(.1)),
                    )
                  ],
                ),
              );
            }
          ),
        ));
  }
}

