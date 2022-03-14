import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/home_menu_model.dart';
import 'package:tashfia_export/util/dashboard_tile.dart';
import 'package:tashfia_export/util/decoration.dart';
import 'package:tashfia_export/variables/config.dart';
import 'package:tashfia_export/widgets/loading_widget.dart';
import '../variables/color_variable.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('Dashboard', style:StDecoration.boldTextStyle),
                backgroundColor: AllColor.appBgColor,
                elevation: 0.0,
                titleSpacing: 0.0,
                iconTheme: IconThemeData(color: Colors.grey.shade800),
              ),
              body: _bodyUI(pc),
            ),
            if(pc.loading.value) const LoadingWidget()
          ],
        );
      }
    );
  }

  Widget _bodyUI(PublicController pc)=>ListView.separated(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
    itemCount: HomeMenuModel.dashboardDataList.length,
    separatorBuilder: (context,index)=>SizedBox(height: dynamicSize(.04)),
    itemBuilder: (context, index)=> DashboardTile(model: HomeMenuModel.dashboardDataList[index])
  );
}
