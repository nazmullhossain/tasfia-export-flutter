import 'dart:convert';

SalesProfitLossListModel salesProfitLossListModelFromJson(String str) => SalesProfitLossListModel.fromJson(json.decode(str));

class SalesProfitLossListModel {
  SalesProfitLossListModel({
    this.profitOrLoss,
    this.data
  });

  final List<SalesProfitLossModel>? data;
  final dynamic profitOrLoss;

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
    this.customer,
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
  final Customer? customer;

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
