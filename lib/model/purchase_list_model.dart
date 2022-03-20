import 'dart:convert';

PurchaseListModel purchaseListModelFromJson(String str) => PurchaseListModel.fromJson(json.decode(str));

class PurchaseListModel {
  PurchaseListModel({
    this.data,
  });

  final List<Purchase>? data;

  factory PurchaseListModel.fromJson(Map<String, dynamic> json) => PurchaseListModel(
    data: List<Purchase>.from(json["data"].map((x) => Purchase.fromJson(x))),
  );
}

class Purchase {
  Purchase({
    this.id,
    this.productId,
    this.supplierId,
    this.createdBy,
    this.quantity,
    this.paymentMode,
    this.mainQuantity,
    this.status,
    this.unitPrice,
    this.totalPurchasPrice,
    this.actualUnitPrice,
    this.paymentAmount,
    this.due,
    this.actualPurchasPrice,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? productId;
  final int? supplierId;
  final String? createdBy;
  final String? quantity;
  final String? paymentMode;
  final String? mainQuantity;
  final int? status;
  final String? unitPrice;
  final String? totalPurchasPrice;
  final String? actualUnitPrice;
  final String? paymentAmount;
  final String? due;
  final String? actualPurchasPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json["id"],
    productId: json["product_id"],
    supplierId: json["supplier_id"],
    createdBy: json["created_by"],
    quantity: json["quantity"],
    paymentMode: json["payment_mode"],
    mainQuantity: json["main_quantity"],
    status: json["status"],
    unitPrice: json["unit_price"],
    totalPurchasPrice: json["total_purchas_price"],
    actualUnitPrice: json["actual_unit_price"],
    paymentAmount: json["payment_amount"],
    due: json["due"],
    actualPurchasPrice: json["actual_purchas_price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
