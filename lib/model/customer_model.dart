// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

class CustomerModel {
  CustomerModel({
    this.data,
  });

  final List<Customer>? data;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    data: List<Customer>.from(json["data"].map((x) => Customer.fromJson(x))),
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
    this.totalPaymentAmount,
    this.totalDue,
    this.totalSalesAmount,
    this.salesHistory,
    this.paymentHistory,
    this.company,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final String? type;
  final dynamic email;
  final dynamic personalPhone;
  final dynamic optionalPhone;
  final String? presentAddress;
  final dynamic companyName;
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
  final String? totalPaymentAmount;
  final String? totalDue;
  final String? totalSalesAmount;
  final List<SalesHistory>? salesHistory;
  final List<dynamic>? paymentHistory;
  final Company? company;

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
    totalPaymentAmount: json["total_payment_amount"],
    totalDue: json["total_due"],
    totalSalesAmount: json["total_sales_amount"],
    salesHistory: List<SalesHistory>.from(json["sales_history"].map((x) => SalesHistory.fromJson(x))),
    paymentHistory: List<dynamic>.from(json["payment_history"].map((x) => x)),
    company: Company.fromJson(json["company"]),
  );
}

class Company {
  Company({
    this.id,
    this.companyName,
    this.category,
    this.companyAddress,
    this.companyContactNo,
    this.country,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? companyName;
  final String? category;
  final String? companyAddress;
  final dynamic companyContactNo;
  final String? country;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    companyName: json["company_name"],
    category: json["category"],
    companyAddress: json["company_address"],
    companyContactNo: json["company_contact_no"],
    country: json["country"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class SalesHistory {
  SalesHistory({
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

  factory SalesHistory.fromJson(Map<String, dynamic> json) => SalesHistory(
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
