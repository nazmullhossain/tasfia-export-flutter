import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tashfia_export/pages/change_password_page.dart';
import 'package:tashfia_export/widgets/loading_widget.dart';
import '../controller/public_controller.dart';
import '../model/home_menu_model.dart';
import '../variables/color_variable.dart';
import '../variables/config.dart';
import '../util/home_menu_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData()async{
    await Future.delayed(const Duration(milliseconds: 50));
    PublicController.pc.getAllCustomer();
    PublicController.pc.getAllSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return Stack(
          children: [
            Scaffold(
              key: _scaffoldKey,
              body: _bodyUI(pc),
            ),
            if(pc.loading.value) const LoadingWidget()
          ],
        );
      }
    );
  }

  Widget _bodyUI(PublicController pc)=>SafeArea(
    child: Column(
      children: [
        ///AppBar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: ()=> _scaffoldKey.currentState!.openDrawer(),
                  child: Icon(LineAwesomeIcons.bars,color: AllColor.textColor,size: dynamicSize(.075))),
              PopupMenuButton<int>(
                key: _key,
                icon: Icon(LineAwesomeIcons.vertical_ellipsis,size: dynamicSize(.07)),
                onSelected: (int val)async{
                  if(val==1){
                    Get.to(()=> ChangePasswordPage());
                  } else if(val==2){
                    await pc.logout();
                  }
                },
                itemBuilder: (context) {
                  return <PopupMenuEntry<int>>[
                    PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(LineAwesomeIcons.key,color: AllColor.textColor,size: dynamicSize(.06)),
                            SizedBox(width: dynamicSize(.02)),
                            Text('Change Password',
                            style: TextStyle(fontSize: dynamicSize(.045),
                                color: AllColor.textColor)),
                          ],
                        ), value: 1,
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10),
                    ),

                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(LineAwesomeIcons.alternate_sign_out,color: AllColor.textColor,size: dynamicSize(.06)),
                          SizedBox(width: dynamicSize(.02)),
                          Text('Logout',
                              style: TextStyle(fontSize: dynamicSize(.045),
                                  color: AllColor.textColor)),
                        ],
                      ), value: 2,
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10),
                    ),
                  ];
                },
                padding: const EdgeInsets.all(0.0),
                tooltip: 'Select an option',
                offset: Offset(0,dynamicSize(.1)),
              ),
            ],
          ),
        ),

        Expanded(
          child: GridView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: dynamicSize(.04),vertical: dynamicSize(.02)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: dynamicSize(.05),
              mainAxisSpacing: dynamicSize(.05)),
            physics: const BouncingScrollPhysics(),
            children: HomeMenuModel.homeMenuDataList.map((element) => HomeMenuTile(model: element)).toList(),
          ),
        )
      ],
    ),
  );
}
