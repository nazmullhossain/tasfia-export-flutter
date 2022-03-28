import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

class DashboardModel {
  DashboardModel({
    this.todayTotalSalesQuantity,
    this.todaySalesAmount,
    this.currentMonthTotalSalesQuantity,
    this.currentMonthSalesAmount,
    this.todayPurchaseQuantity,
    this.todayPurchaseAmount,
    this.currentMonthPurchaseQuantity,
    this.currentMonthPurchaseAmount,
    this.todayDueAmount,
    this.todayDueQuantity,
    this.currentMonthDueAmount,
    this.currentMonthDueQuantity,
  });

  final int? todayTotalSalesQuantity;
  final int? todaySalesAmount;
  final int? currentMonthTotalSalesQuantity;
  final int? currentMonthSalesAmount;
  final int? todayPurchaseQuantity;
  final int? todayPurchaseAmount;
  final String? currentMonthPurchaseQuantity;
  final String? currentMonthPurchaseAmount;
  final int? todayDueAmount;
  final int? todayDueQuantity;
  final int? currentMonthDueAmount;
  final int? currentMonthDueQuantity;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    todayTotalSalesQuantity: json["today_total_sales_quantity"],
    todaySalesAmount: json["today_sales_amount"],
    currentMonthTotalSalesQuantity: json["current_month_total_sales_quantity"],
    currentMonthSalesAmount: json["current_month_sales_amount"],
    todayPurchaseQuantity: json["today_purchase_quantity"],
    todayPurchaseAmount: json["today_purchase_amount"],
    currentMonthPurchaseQuantity: json["current_month_purchase_quantity"],
    currentMonthPurchaseAmount: json["current_month_purchase_amount"],
    todayDueAmount: json["today_due_amount"],
    todayDueQuantity: json["today_due_quantity"],
    currentMonthDueAmount: json["current_month_due_amount"],
    currentMonthDueQuantity: json["current_month_due_quantity"],
  );
}
