import 'dart:convert';

SalesProfitLossListModel salesProfitLossListModelFromJson(String str) => SalesProfitLossListModel.fromJson(json.decode(str));

class SalesProfitLossListModel {
  SalesProfitLossListModel({
    this.data,
    this.profitOrLoss,
  });

  final List<SalesProfitLossModel>? data;
  final double? profitOrLoss;

  factory SalesProfitLossListModel.fromJson(Map<String, dynamic> json) => SalesProfitLossListModel(
    data: List<SalesProfitLossModel>.from(json["data"].map((x) => SalesProfitLossModel.fromJson(x))),
    profitOrLoss: json["profit_or_loss"].toDouble(),
  );

}

class SalesProfitLossModel {
  SalesProfitLossModel({
    this.customerId,
    this.totalPrice,
    this.paymentAmount,
    this.due,
    this.labourBill,
    this.salesCode,
    this.profitOrLoss,
    this.status,
    this.createdAt,
  });

  final int? customerId;
  final String? totalPrice;
  final String? paymentAmount;
  final String? due;
  final String? labourBill;
  final String? salesCode;
  final String? profitOrLoss;
  final int? status;
  final DateTime? createdAt;

  factory SalesProfitLossModel.fromJson(Map<String, dynamic> json) => SalesProfitLossModel(
    customerId: json["customer_id"],
    totalPrice: json["total_price"],
    paymentAmount: json["payment_amount"],
    due: json["due"],
    labourBill: json["labour_bill"],
    salesCode: json["sales_code"],
    profitOrLoss: json["profit_or_loss"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );

}
