import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controller/public_controller.dart';
import '../util/employee_tile.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../widgets/loading_widget.dart';

class AllEmployeePage extends StatefulWidget {
  const AllEmployeePage({Key? key}) : super(key: key);

  @override
  State<AllEmployeePage> createState() => _AllEmployeePageState();
}

class _AllEmployeePageState extends State<AllEmployeePage> {

  @override
  void initState(){
    super.initState();
    _initData();
  }
  Future<void> _initData()async{
    if(PublicController.pc.allEmployeeModel.value.data==null){
      await PublicController.pc.getAllEmployee();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(builder: (pc){
      return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('সকল কর্মচারী', style:StDecoration.boldTextStyle),
              backgroundColor: AllColor.appBgColor,
              elevation: 0.0,
              titleSpacing: 0.0,
              iconTheme: IconThemeData(color: Colors.grey.shade800),
              actions: [
                IconButton(onPressed: ()async{
                  pc.loading(true);pc.update();
                  await pc.getAllEmployee();
                  pc.loading(false);pc.update();
                 },
                 icon: Icon(LineAwesomeIcons.alternate_redo,size: dynamicSize(.065))),
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
    onRefresh: ()async=>await pc.getAllEmployee(),
    backgroundColor: Colors.white,
    child: pc.allEmployeeModel.value.data!=null?ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
        itemCount: pc.allEmployeeModel.value.data!.length,
        itemBuilder: (context, index)=> AllEmployeeTile(model: pc.allEmployeeModel.value.data![index]),
        separatorBuilder: (context, index)=>SizedBox(height: dynamicSize(.04))):Container(),
  );
}
