import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

class CustomerModel {
  CustomerModel({
    this.customers,
  });

  final List<Customer>? customers;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
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
  final String? email;
  final String? personalPhone;
  final String? optionalPhone;
  final String? presentAddress;
  final dynamic companyName;
  final String? permanentAddress;
  final String? balance;
  final String? reference;
  final String? nid;
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
