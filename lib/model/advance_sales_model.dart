import 'dart:convert';

AdvanceSaleListModel advanceSaleListModelFromJson(String str) => AdvanceSaleListModel.fromJson(json.decode(str));

class AdvanceSaleListModel {
  AdvanceSaleListModel({
    this.data,
  });
  final List<AdvanceSaleModel>? data;

  factory AdvanceSaleListModel.fromJson(Map<String, dynamic> json) => AdvanceSaleListModel(
    data: List<AdvanceSaleModel>.from(json["data"].map((x) => AdvanceSaleModel.fromJson(x))),
  );
}

class AdvanceSaleModel {
  AdvanceSaleModel({
    this.id,
    this.partyId,
    this.productId,
    this.invoiceDate,
    this.dueDate,
    this.clientName,
    this.email,
    this.phone,
    this.address,
    this.projectDesc,
    this.subtotal,
    this.tax,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? partyId;
  final int? productId;
  final DateTime? invoiceDate;
  final DateTime? dueDate;
  final dynamic clientName;
  final dynamic email;
  final dynamic phone;
  final dynamic address;
  final String? projectDesc;
  final String? subtotal;
  final String? tax;
  final String? totalAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AdvanceSaleModel.fromJson(Map<String, dynamic> json) => AdvanceSaleModel(
    id: json["id"],
    partyId: json["party_id"],
    productId: json["product_id"],
    invoiceDate: DateTime.parse(json["invoice_date"]),
    dueDate: DateTime.parse(json["due_date"]),
    clientName: json["client_name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    projectDesc: json["project_desc"],
    subtotal: json["subtotal"],
    tax: json["tax"],
    totalAmount: json["total_amount"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
