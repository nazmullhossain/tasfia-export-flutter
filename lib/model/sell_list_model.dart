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
    this.nid,
    this.photo,
    this.nationality,
    this.designation,
    this.category,
    this.companyAddress,
    this.companyContactNo,
    this.country,
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
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? companyId;
  final String? name;
  final String? type;
  final dynamic email;
  final dynamic personalPhone;
  final dynamic optionalPhone;
  final String? presentAddress;
  final String? companyName;
  final String? permanentAddress;
  final String? balance;
  final dynamic nid;
  final String? photo;
  final String? nationality;
  final String? designation;
  final String? category;
  final String? companyAddress;
  final dynamic companyContactNo;
  final String? country;

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
    nid: json["nid"],
    photo: json["photo"],
    nationality: json["nationality"],
    designation: json["designation"],
    category: json["category"],
    companyAddress: json["company_address"],
    companyContactNo: json["company_contact_no"],
    country: json["country"],
  );
}
