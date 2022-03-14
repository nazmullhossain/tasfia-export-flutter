import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/variables/variable.dart';
import 'package:http/http.dart' as http;

class ApiHelper{

  Future<bool> getLoginResponse(String email, String password)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'login?email=$email&password=$password'));
      if(response.statusCode==200){
        PublicController.pc.loginResponse(loginResponseFromJson(response.body));
        PublicController.pc.pref!.setString('email', email);
        PublicController.pc.pref!.setString('password', password);
        print(PublicController.pc.loginResponse.value.token);
        return true;
      }else{
        showToast('Invalid email or password');
        return false;
      }
    }on SocketException{
      showToast('No internet connection');
      return false;
    }catch(error){
      print(error.toString());
      showToast(error.toString());
      return false;
    }
  }

  Future<void> allCustomersResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'customers'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        print(response.body);

      }else{showToast('Customer get Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }

  Future<void> allSuppliersResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'suppliers'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        print(response.body);

      }else{showToast('Suppliers get Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }
}