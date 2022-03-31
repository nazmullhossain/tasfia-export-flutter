import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
    "today_total_sales_quantity": todayTotalSalesQuantity,
    "today_sales_amount": todaySalesAmount,
    "current_month_total_sales_quantity": currentMonthTotalSalesQuantity,
    "current_month_sales_amount": currentMonthSalesAmount,
    "today_purchase_quantity": todayPurchaseQuantity,
    "today_purchase_amount": todayPurchaseAmount,
    "current_month_purchase_quantity": currentMonthPurchaseQuantity,
    "current_month_purchase_amount": currentMonthPurchaseAmount,
    "today_due_amount": todayDueAmount,
    "today_due_quantity": todayDueQuantity,
    "current_month_due_amount": currentMonthDueAmount,
    "current_month_due_quantity": currentMonthDueQuantity,
  };
}
