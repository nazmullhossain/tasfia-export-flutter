import 'dart:convert';

StockListModel stockListModelFromJson(String str) => StockListModel.fromJson(json.decode(str));

class StockListModel {
  StockListModel({
    this.data,
  });

  final List<StockModel>? data;

  factory StockListModel.fromJson(Map<String, dynamic> json) => StockListModel(
    data: List<StockModel>.from(json["data"].map((x) => StockModel.fromJson(x))),
  );
}

class StockModel {
  StockModel({
    this.id,
    this.purchaseId,
    this.createdBy,
    this.quantity,
    this.mainQuantity,
    this.status,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? purchaseId;
  final String? createdBy;
  final String? quantity;
  final String? mainQuantity;
  final String? status;
  final dynamic date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    id: json["id"],
    purchaseId: json["purchase_id"],
    createdBy: json["created_by"],
    quantity: json["quantity"],
    mainQuantity: json["main_quantity"],
    status: json["status"],
    date: json["date"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  
}
