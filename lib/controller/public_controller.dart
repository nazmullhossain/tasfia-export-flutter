import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tashfia_export/controller/api_helper.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/pages/home_page.dart';

import '../variables/variable.dart';

class PublicController extends GetxController{
  static PublicController pc = Get.find();
  ApiHelper helper = ApiHelper();
  late SharedPreferences? pref;
  RxDouble size = 0.0.obs;
  RxBool loading=false.obs;

  Rx<LoginResponse> loginResponse = LoginResponse().obs;


  Future<void> initApp(BuildContext context) async {
    pref = await SharedPreferences.getInstance();
    if (MediaQuery.of(context).size.width<=500) {
      size(MediaQuery.of(context).size.width);
    } else {size(MediaQuery.of(context).size.height);}
    update();
    if (kDebugMode) {
      print('Initialized\n Size: ${size.value}');
    }
  }
  Future<void> logout()async{
    await pref!.clear();
  }

  Future<void> login(String email, String password)async{
    loading(true);update();
    bool result = await helper.getLoginResponse(email, password);
    loading(false);update();
    if(result){
      showToast('Login Success');
      Get.offAll(()=> const HomePage());
    }
  }

  Future<void> getAllCustomer()async{
    await helper.allCustomersResponse();
  }

  Future<void> getAllSupplier()async{
    await helper.allSuppliersResponse();
  }
}