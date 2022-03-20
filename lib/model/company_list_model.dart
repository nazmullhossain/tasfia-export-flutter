// To parse this JSON data, do
//
//     final companyListModel = companyListModelFromJson(jsonString);

import 'dart:convert';

CompanyListModel companyListModelFromJson(String str) => CompanyListModel.fromJson(json.decode(str));

class CompanyListModel {
  CompanyListModel({
    this.data,
  });

  final List<CompanyModel>? data;

  factory CompanyListModel.fromJson(Map<String, dynamic> json) => CompanyListModel(
    data: List<CompanyModel>.from(json["data"].map((x) => CompanyModel.fromJson(x))),
  );
}

class CompanyModel {
  CompanyModel({
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

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
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
