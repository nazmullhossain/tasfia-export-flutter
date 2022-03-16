import 'dart:convert';
import 'dart:io';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/account_summery_model.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/model/dashboard_model.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/model/supplier_model.dart';
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

  Future<void> dashboardResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'total_sales_purchase_due_report'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        PublicController.pc.dashboardModel(dashboardModelFromJson(response.body));
        print('Dashboard: ${PublicController.pc.dashboardModel.value.todayTotalSalesQuantity}');
      }else{showToast('Dashboard Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }

  Future<void> allCustomersResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'customers'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
       PublicController.pc.customerModel(customerModelFromJson(response.body));
       print('Customers: ${PublicController.pc.customerModel.value.customers!.length}');
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
        PublicController.pc.supplierModel(supplierModelFromJson(response.body));
        print('Suppliers: ${PublicController.pc.supplierModel.value.suppliers!.length}');
      }else{showToast('Suppliers get Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }

  Future<void> accountSummeryResponse(String fromDate, String toDate)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'account_summary?from_date=$fromDate&to_date=$toDate'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        PublicController.pc.accountSummery(accountSummeryModelFromJson(response.body));
      }else{showToast('`Failed to get report');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }
}