import 'dart:convert';

AssetListModel assetListModelFromJson(String str) => AssetListModel.fromJson(json.decode(str));

class AssetListModel {
  AssetListModel({this.data});
  final List<AssetModel>? data;

  factory AssetListModel.fromJson(Map<String, dynamic> json) => AssetListModel(
    data: List<AssetModel>.from(json["data"].map((x) => AssetModel.fromJson(x))),
  );
}

class AssetModel {
  AssetModel({
    this.id,
    this.categoryId,
    this.name,
    this.balance,
    this.amount,
    this.remarks,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? categoryId;
  final String? name;
  final dynamic balance;
  final String? amount;
  final String? remarks;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    balance: json["balance"],
    amount: json["Amount"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}
