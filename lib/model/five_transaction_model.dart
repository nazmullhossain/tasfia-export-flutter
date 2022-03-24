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
    this.customer,
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
  final Customer? customer;

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
    customer: Customer.fromJson(json["customer"]),
  );
}

class Customer {
  Customer({
    this.id,
    this.companyId,
    this.name,
    this.type,
    this.email,
    this.personalPhone,
    this.optionalPhone,
    this.presentAddress,
    this.companyName,
    this.permanentAddress,
    this.balance,
    this.reference,
    this.nid,
    this.photo,
    this.nationality,
    this.designation,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final String? type;
  final dynamic email;
  final String? personalPhone;
  final dynamic optionalPhone;
  final String? presentAddress;
  final String? companyName;
  final String? permanentAddress;
  final String? balance;
  final dynamic reference;
  final dynamic nid;
  final String? photo;
  final String? nationality;
  final String? designation;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    companyId: json["company_id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    personalPhone: json["personal_phone"],
    optionalPhone: json["optional_phone"],
    presentAddress: json["present_address"],
    companyName: json["company_name"],
    permanentAddress: json["permanent_address"],
    balance: json["balance"],
    reference: json["reference"],
    nid: json["nid"],
    photo: json["photo"],
    nationality: json["nationality"],
    designation: json["designation"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
