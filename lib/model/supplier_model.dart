import 'dart:convert';

SupplierModel supplierModelFromJson(String str) => SupplierModel.fromJson(json.decode(str));

class SupplierModel {
  SupplierModel({
    this.suppliers,
  });

  final List<Supplier>? suppliers;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
    suppliers: List<Supplier>.from(json["suppliers"].map((x) => Supplier.fromJson(x))),
  );
}

class Supplier {
  Supplier({
    this.id,
    this.companyId,
    this.name,
    this.email,
    this.personalPhone,
    this.optionalPhone,
    this.presentAddress,
    this.permanentAddress,
    this.balance,
    this.companyName,
    this.companyAddress,
    this.companyContactNo,
    this.reference,
    this.nid,
    this.photo,
    this.nationality,
    this.designation,
    this.country,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final String? email;
  final dynamic personalPhone;
  final String? optionalPhone;
  final String? presentAddress;
  final String? permanentAddress;
  final String? balance;
  final dynamic companyName;
  final dynamic companyAddress;
  final dynamic companyContactNo;
  final dynamic reference;
  final String? nid;
  final String? photo;
  final String? nationality;
  final String? designation;
  final dynamic country;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    companyId: json["company_id"],
    name: json["name"],
    email: json["email"],
    personalPhone: json["personal_phone"],
    optionalPhone: json["optional_phone"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    balance: json["balance"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    companyContactNo: json["company_contact_no"],
    reference: json["reference"],
    nid: json["nid"],
    photo: json["photo"],
    nationality: json["nationality"],
    designation: json["designation"],
    country: json["country"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
