import 'dart:convert';
import 'dart:io';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/account_summery_model.dart';
import 'package:tashfia_export/model/company_list_model.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/model/dashboard_model.dart';
import 'package:tashfia_export/model/employee_model.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/model/product_list_model.dart';
import 'package:tashfia_export/model/purchase_list_model.dart';
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
      showToast(error.toString());
      return false;
    }
  }

  Future<void> getCompanyResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'company_list'),headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.companyModel(companyListModelFromJson(response.body));
        }else{showToast('No company found');}
      }else{
        showToast('Company list fetch problem');
      }
    }on SocketException{
      showToast('No internet connection');
      getCompanyResponse();
    }catch(error){
      showToast(error.toString());
      getCompanyResponse();
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

  Future<void> searchCustomersResponse(Map<String,String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_customer?name=${map['name']}&phone=${map['phone']}'
              '&company_name=${map['company_name']}&customer_id=${map['customer_id']}'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.customerModel(customerModelFromJson(response.body));
        }else{showToast('No Customer found');}
      }
      else{showToast('Customer get Failed');}
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

  Future<void> searchSupplierResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_supplier?name=${map['name']}&phone=${map['phone']}'
              '&company_name=${map['company_name']}&customer_id=${map['customer_id']}'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.supplierModel(supplierModelFromJson(response.body));
        }else{showToast('No supplier found');}
      }
      else{showToast('Supplier get Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
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
      }else{showToast('Failed to get report');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      print(error.toString());
      showToast(error.toString());
    }
  }

  Future<void> allEmployeeResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'employee_list'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.allEmployeeModel(employeeModelFromJson(response.body));
        }else{showToast('No employee found');}
      }else{showToast('Failed to get employee');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> allProductResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_product'),
          headers: Variables().authHeader);

      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.productListModel(productListModelFromJson(response.body));
        }else{showToast('No product found');}
      }else{showToast('Failed to get product');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchProductResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_product?product_name=${map['product_name']}'
              '&bar_code=${map['bar_code']}&party_name=${map['party_name']}'),
          headers: Variables().authHeader);

      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.productListModel(productListModelFromJson(response.body));
        }else{showToast('No product found');}
      }else{showToast('Failed to get product');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> allPurchaseResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_purchase'),
          headers: Variables().authHeader);

      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.purchaseListModel(purchaseListModelFromJson(response.body));
        }else{showToast('No purchase found');}
      }else{showToast('Failed to get purchase');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchPurchaseResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_purchase?from_date=${map['from_date']}&to_date=${map['to_date']}'
              '&search_company_id=${map['search_company_id']}&product_name=${map['product_name']}'
              '&search_supplier_id=${map['search_supplier_id']}'),
          headers: Variables().authHeader);

      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.purchaseListModel(purchaseListModelFromJson(response.body));
        }else{showToast('No purchase found');}
      }else{showToast('Failed to get purchase');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }
}