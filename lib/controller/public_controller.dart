import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tashfia_export/controller/api_helper.dart';
import 'package:tashfia_export/model/account_summery_model.dart';
import 'package:tashfia_export/model/asset_list_model.dart';
import 'package:tashfia_export/model/category_list_model.dart';
import 'package:tashfia_export/model/company_list_model.dart';
import 'package:tashfia_export/model/customer_model.dart';
import 'package:tashfia_export/model/dashboard_model.dart';
import 'package:tashfia_export/model/employee_model.dart';
import 'package:tashfia_export/model/expense_list_model.dart';
import 'package:tashfia_export/model/five_transaction_model.dart';
import 'package:tashfia_export/model/login_response.dart';
import 'package:tashfia_export/model/opening_balance_model.dart';
import 'package:tashfia_export/model/product_list_model.dart';
import 'package:tashfia_export/model/purchase_list_model.dart';
import 'package:tashfia_export/model/sales_profit_loss_model.dart';
import 'package:tashfia_export/model/sales_list_model.dart';
import 'package:tashfia_export/model/stock_list_model.dart';
import 'package:tashfia_export/model/supplier_model.dart';
import 'package:tashfia_export/pages/home_page.dart';
import 'package:tashfia_export/pages/login_page.dart';
import '../variables/variable.dart';

class PublicController extends GetxController{
  static PublicController pc = Get.find();
  ApiHelper helper = ApiHelper();
  late SharedPreferences? pref;
  RxDouble size = 0.0.obs;
  RxBool loading=false.obs;

  Rx<LoginResponse> loginResponse = LoginResponse().obs;
  Rx<CustomerModel> customerModel = CustomerModel().obs;
  Rx<SupplierModel> supplierModel = SupplierModel().obs;
  Rx<AccountSummeryModel> accountSummery = AccountSummeryModel().obs;
  Rx<DashboardModel> dashboardModel = DashboardModel().obs;
  Rx<CompanyListModel> companyModel = CompanyListModel().obs;
  Rx<CategoryListModel> categoryModel = CategoryListModel().obs;
  Rx<EmployeeModel> allEmployeeModel = EmployeeModel().obs;
  Rx<ProductListModel> productListModel = ProductListModel().obs;
  Rx<PurchaseListModel> purchaseListModel = PurchaseListModel().obs;
  Rx<OpeningBalanceListModel> openingBalanceModel = OpeningBalanceListModel().obs;
  Rx<SalesProfitLossListModel> salesProfitLossModel = SalesProfitLossListModel().obs;
  Rx<FiveTransactionListModel> fiveTransactionModel = FiveTransactionListModel().obs;
  Rx<SalesListModel> sellModel = SalesListModel().obs;
  Rx<StockListModel> stockModel = StockListModel().obs;
  Rx<ExpenseListModel> expenseModel = ExpenseListModel().obs;
  Rx<AssetListModel> assetModel = AssetListModel().obs;

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
    loading(false);
    update();
    Get.offAll(()=>const LoginPage());
  }

  Future<void> login(String email, String password)async{
    loading(true);update();
    bool result = await helper.getLoginResponse(email, password);
    loading(false);update();
    if(result==true){
      showToast('Login Success');
      Get.offAll(()=> const HomePage());
    }
  }

  Future<void> getCompanyList()async{
    await helper.getCompanyResponse();
    update();
  }

  Future<void> getCategoryList()async{
    await helper.getCategoryResponse();
    update();
  }

  Future<void> getDashboardData()async{
    await helper.dashboardResponse();
    update();
  }

  Future<void> getLastFiveTransaction()async{
    await helper.fiveTransactionResponse();
    update();
  }

  Future<void> getAllCustomer()async{
    await helper.allCustomersResponse();
    update();
  }

  Future<void> searchCustomer(Map<String,String> map)async{
    loading(true);update();
    await helper.searchCustomersResponse(map);
    loading(false);update();
  }

  Future<void> getAllSupplier()async{
    await helper.allSuppliersResponse();
    update();
  }

  Future<void> searchSupplier(Map<String, String> map)async{
    loading(true);update();
    await helper.searchSupplierResponse(map);
    loading(false);update();
  }

  Future<void> getAccountSummery(String fromDate, String toDate)async{
    loading(true);update();
    await helper.accountSummeryResponse(fromDate,toDate);
    loading(false);update();
  }

  Future<void> getAllEmployee()async{
    await helper.allEmployeeResponse();
    update();
  }

  Future<void> getAllProduct()async{
    await helper.allProductResponse();
    update();
  }

  Future<void> searchProduct(Map<String, String> map)async{
    loading(true);update();
    await helper.searchProductResponse(map);
    loading(false);update();
  }

  Future<void> getAllPurchase()async{
    await helper.allPurchaseResponse();
    update();
  }

  Future<void> searchPurchase(Map<String, String> map)async{
    loading(true);update();
    await helper.searchPurchaseResponse(map);
    loading(false);update();
  }

  Future<void> getOpeningBalance()async{
    await helper.dailyOpeningBalanceResponse();
    update();
  }

  Future<void> searchSalesProfitLoss(String fromDate, String toDate)async{
    loading(true);update();
    await helper.salesProfitLossResponse(fromDate, toDate);
    loading(false);update();
  }

  Future<void> changePassword(String currentPass,String newPass,String confirmPass)async{
    loading(true);update();
    bool result = await helper.changePasswordResponse(currentPass, newPass, confirmPass);
    loading(false);update();
    if(result){
      pref!.setString('password', newPass);
      showToast('পাসওয়ার্ড সফলভাবে আপডেট হয়েছে');
      update();
    }
  }

  Future<void> getSellList()async{
    await helper.sellListResponse();
    update();
  }

  Future<void> searchSellList(Map<String, String> map)async{
    loading(true);update();
    await helper.searchSelResponse(map);
    loading(false);update();
  }

  Future<void> getStockList()async{
    await helper.stockListResponse();
    update();
  }

  Future<void> searchStockList(Map<String, String> map)async{
    loading(true);update();
    await helper.searchStockListResponse(map);
    loading(false);update();
  }

  Future<void> getExpenseList()async{
    await helper.expenseListResponse();
    update();
  }

  Future<void> searchExpenseList(Map<String, String> map)async{
    loading(true);update();
    await helper.searchExpenseListResponse(map);
    loading(false);update();
  }

  Future<void> getAssetList()async{
    await helper.assetListResponse();
    update();
  }

  Future<void> searchAssetList(Map<String, String> map)async{
    loading(true);update();
    await helper.searchAssetListResponse(map);
    loading(false);update();
  }
}