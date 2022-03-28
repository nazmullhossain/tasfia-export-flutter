import 'dart:convert';
import 'dart:io';
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/advance_sales_model.dart';
import 'package:tashfia_export/model/asset_expense_report_model.dart';
import 'package:tashfia_export/model/asset_list_model.dart';
import 'package:tashfia_export/model/category_list_model.dart';
import 'package:tashfia_export/model/company_list_model.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/model/dashboard_model.dart';
import 'package:tashfia_export/model/employee_model.dart';
import 'package:tashfia_export/model/expense_list_model.dart';
import 'package:tashfia_export/model/five_transaction_model.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/model/product_list_model.dart';
import 'package:tashfia_export/model/purchase_list_model.dart';
import 'package:tashfia_export/model/sales_profit_loss_model.dart';
import 'package:tashfia_export/model/stock_list_model.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/variables/variable.dart';
import 'package:http/http.dart' as http;
import '../model/opening_balance_model.dart';
import '../model/sales_list_model.dart';

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

  Future<void> getCategoryResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'assetExpenseCategory'),headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        if(jsonData['data'].isNotEmpty){
          PublicController.pc.categoryModel(categoryListModelFromJson(response.body));
        }else{showToast('No category found');}
      }else{
        showToast('Category list fetching problem');
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

  Future<void> fiveTransactionResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'last_five_transaction'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.fiveTransactionModel(fiveTransactionListModelFromJson(response.body));
      }else{showToast('Failed to get five transaction');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> allCustomersResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_customer'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
       PublicController.pc.customerModel(customerModelFromJson(response.body));
       print('Customers: ${PublicController.pc.customerModel.value.data!.length}');
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
        PublicController.pc.customerModel(customerModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('No Customer found');
      }
      else{showToast('Customer get Failed');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> allSuppliersResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_supplier'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        PublicController.pc.supplierModel(supplierModelFromJson(response.body));
        print('Suppliers: ${PublicController.pc.supplierModel.value.data!.length}');
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

  Future<void> accountAssetExpenseResponse(String fromDate, String toDate)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'expense_asset_report?from_date=$fromDate&to_date=$toDate'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        PublicController.pc.assetExpanseReportModel(assetExpenseReportModelFromJson(response.body));
      }else{showToast('Failed to get asset & expense report');}
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
        PublicController.pc.allEmployeeModel(employeeModelFromJson(response.body));
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
        PublicController.pc.productListModel(productListModelFromJson(response.body));
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
        PublicController.pc.productListModel(productListModelFromJson(response.body));
        if(jsonData['data'].isEmpty)showToast('No product found');
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
        PublicController.pc.purchaseListModel(purchaseListModelFromJson(response.body));
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
        PublicController.pc.purchaseListModel(purchaseListModelFromJson(response.body));
        if(jsonData['data'].isEmpty)showToast('No purchase found');
      }else{showToast('Failed to get purchase');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> dailyOpeningBalanceResponse()async{
    try{
      var response = await http.get(
          Uri.parse(Variables.baseUrl+'daily_opening_closing_balance'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
         PublicController.pc.openingBalanceModel(openingBalanceListModelFromJson(response.body));
      }else{showToast('Failed to get opening balance');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> salesProfitLossResponse(String fromDate, String toDate)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'profit_loss?from_date=$fromDate&to_date=$toDate'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.salesProfitLossModel(salesProfitLossListModelFromJson(response.body));
      }else{showToast('Failed to get sales profit loss');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<bool> changePasswordResponse(String currentPass,String newPass,String confirmPass)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'change_password?current_password=$currentPass'
              '&password=$newPass&password_confirmation=$confirmPass'),
          headers: Variables().authHeader);
      if(response.statusCode==201){
        return true;
      }else{
        showToast('Update failed');
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

  Future<void> sellListResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_sales_history'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.sellModel(sellListModelFromJson(response.body));
      }else{showToast('Failed to get Sells');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchSelResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_sales_history?from_date=${map['from_date']}'
              '&to_date=${map['to_date']}&search_payment_status=${map['search_payment_status']}'
              '&search_company_id=${map['search_company_id']}&search_customer_id=${map['search_customer_id']}'
              '&invoice_number=${map['invoice_number']}'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        PublicController.pc.sellModel(sellListModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('No sells found');
      }else{showToast('Failed to get Sells');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> stockListResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_stock'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.stockModel(stockListModelFromJson(response.body));
      }else{showToast('Failed to get stock');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchStockListResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_stock?from_date=${map['from_date']}&to_date=${map['to_date']}'
              '&search_supplier_id=${map['search_supplier_id']}&product_name=${map['product_name']}'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        PublicController.pc.stockModel(stockListModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('No Stock Found');
      }else{showToast('Failed to search stock');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> expenseListResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_expense'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.expenseModel(expenseListModelFromJson(response.body));
      }else{showToast('Failed to get expense');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchExpenseListResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_expense?from_date=${map['from_date']}'
              '&to_date=${map['to_date']}&search_amount=${map['search_amount']}'
              '&search_name=${map['search_name']}&expenses_category=${map['expenses_category']}'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        PublicController.pc.expenseModel(expenseListModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('No Expense Found');
      }else{showToast('Failed to get expense');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> assetListResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_asset'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        PublicController.pc.assetModel(assetListModelFromJson(response.body));
      }else{showToast('Failed to get assets');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchAssetListResponse(Map<String, String> map)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_asset?from_date=${map['from_date']}'
              '&to_date=${map['to_date']}&search_amount=${map['search_amount']}'
              '&search_name=${map['search_name']}&category=${map['category']}'),
          headers: Variables().authHeader);
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        PublicController.pc.assetModel(assetListModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('No Asset Found');
      }else{showToast('Failed to get asset');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> getAdvanceSaleResponse()async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_advance_sells'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        PublicController.pc.advanceSaleModel(advanceSaleListModelFromJson(response.body));
      }else{showToast('Failed to get advance sell');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> searchAdvanceSaleResponse(String fromDate, String toDate)async{
    try{
      var response = await http.post(
          Uri.parse(Variables.baseUrl+'search_advance_sells?from_date=$fromDate&to_date=$toDate'),
          headers: Variables().authHeader
      );
      if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        PublicController.pc.advanceSaleModel(advanceSaleListModelFromJson(response.body));
        if(jsonData['data'].isEmpty) showToast('Record not found');
      }else{showToast('Failed to search advance sell');}
    }on SocketException{
      showToast('No internet connection');
    }catch(error){
      showToast(error.toString());
    }
  }
}