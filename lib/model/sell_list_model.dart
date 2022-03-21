import 'dart:convert';

SellListModel sellListModelFromJson(String str) => SellListModel.fromJson(json.decode(str));

class SellListModel {
  SellListModel({
    this.data,
  });

  final List<SellModel>? data;

  factory SellListModel.fromJson(Map<String, dynamic> json) => SellListModel(
    data: List<SellModel>.from(json["data"].map((x) => SellModel.fromJson(x))),
  );
}

class SellModel {
  SellModel({
    this.id,
    this.customerId,
    this.salesExecutiveId,
    this.totalPrice,
    this.paymentAmount,
    this.due,
    this.labourBill,
    this.reference,
    this.salesDate,
    this.status,
    this.salesCode,
    this.profitOrLoss,
    this.date,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? customerId;
  final int? salesExecutiveId;
  final String? totalPrice;
  final String? paymentAmount;
  final String? due;
  final String? labourBill;
  final dynamic reference;
  final dynamic salesDate;
  final int? status;
  final String? salesCode;
  final String? profitOrLoss;
  final dynamic date;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory SellModel.fromJson(Map<String, dynamic> json) => SellModel(
    id: json["id"],
    customerId: json["customer_id"],
    salesExecutiveId: json["sales_executive_id"],
    totalPrice: json["total_price"],
    paymentAmount: json["payment_amount"],
    due: json["due"],
    labourBill: json["labour_bill"],
    reference: json["reference"],
    salesDate: json["sales_date"],
    status: json["status"],
    salesCode: json["sales_code"],
    profitOrLoss: json["profit_or_loss"],
    date: json["date"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
