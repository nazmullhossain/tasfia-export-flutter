import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

class DashboardModel {
  DashboardModel({
    this.currentMonthDueAmount,
    this.currentMonthDueQuantity,
    this.currentMonthPurchaseAmount,
    this.currentMonthPurchaseQuantity,
    this.currentMonthSalesAmount,
    this.currentMonthTotalSalesQuantity,
    this.todayDueAmount,
    this.todayDueQuantity,
    this.todayPurchaseAmount,
    this.todayPurchaseQuantity,
    this.todaySalesAmount,
    this.todayTotalSalesQuantity
  });

  final dynamic todayTotalSalesQuantity;
  final dynamic todaySalesAmount;
  final dynamic currentMonthTotalSalesQuantity;
  final dynamic currentMonthSalesAmount;
  final dynamic todayPurchaseQuantity;
  final dynamic todayPurchaseAmount;
  final dynamic currentMonthPurchaseQuantity;
  final dynamic currentMonthPurchaseAmount;
  final dynamic todayDueAmount;
  final dynamic todayDueQuantity;
  final dynamic currentMonthDueAmount;
  final dynamic currentMonthDueQuantity;

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