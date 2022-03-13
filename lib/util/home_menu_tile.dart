import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../variables/config.dart';
import '../controller/public_controller.dart';
import '../model/home_menu_model.dart';


class HomeMenuTile extends StatelessWidget {
  const HomeMenuTile({Key? key, required this.model}) : super(key: key);
  final HomeMenuModel model;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (pc) {
        return  InkWell(
            onTap: (){},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(dynamicSize(.04)),
              decoration: BoxDecoration(
                  color: model.color.withOpacity(.15),
                  borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.05)))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(model.icon,color: model.color,size: dynamicSize(.1)),
                    backgroundColor: Colors.white,
                    radius: dynamicSize(.07),
                  ),
                  SizedBox(height: dynamicSize(.02)),
                  Text(model.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontSize: dynamicSize(.045)
                          ,fontWeight: FontWeight.w600))
                ],
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(dynamicSize(.05)))
        );
      }
    );
  }
}
