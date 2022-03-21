import 'dart:convert';

FiveTransactionListModel fiveTransactionListModelFromJson(String str) => FiveTransactionListModel.fromJson(json.decode(str));

class FiveTransactionListModel {
  FiveTransactionListModel({
    this.data,
  });

  final List<FiveTransactionModel>? data;

  factory FiveTransactionListModel.fromJson(Map<String, dynamic> json) => FiveTransactionListModel(
    data: List<FiveTransactionModel>.from(json["data"].map((x) => FiveTransactionModel.fromJson(x))),
  );
}

class FiveTransactionModel {
  FiveTransactionModel({
    this.id,
    this.salesId,
    this.customerId,
    this.amount,
    this.paymentMode,
    this.bankName,
    this.chequeNumber,
    this.chequeDueDate,
    this.bkashNumber,
    this.bkashTrnsId,
    this.cardNumber,
    this.cardExpireDate,
    this.remark,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? salesId;
  final int? customerId;
  final int? amount;
  final String? paymentMode;
  final dynamic bankName;
  final String? chequeNumber;
  final DateTime? chequeDueDate;
  final dynamic bkashNumber;
  final dynamic bkashTrnsId;
  final dynamic cardNumber;
  final dynamic cardExpireDate;
  final dynamic remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FiveTransactionModel.fromJson(Map<String, dynamic> json) => FiveTransactionModel(
    id: json["id"],
    salesId: json["sales_id"],
    customerId: json["customer_id"],
    amount: json["amount"],
    paymentMode: json["payment_mode"],
    bankName: json["bank_name"],
    chequeNumber: json["cheque_number"],
    chequeDueDate: json["cheque_due_date"] == null ? null : DateTime.parse(json["cheque_due_date"]),
    bkashNumber: json["bkash_number"],
    bkashTrnsId: json["bkash_trns_id"],
    cardNumber: json["card_number"],
    cardExpireDate: json["card_expire_date"],
    remark: json["remark"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  
}
