import 'dart:convert';

OpeningBalanceListModel openingBalanceListModelFromJson(String str) => OpeningBalanceListModel.fromJson(json.decode(str));

class OpeningBalanceListModel {
  OpeningBalanceListModel({
    this.data,
  });

  final List<OpeningBalanceModel>? data;

  factory OpeningBalanceListModel.fromJson(Map<String, dynamic> json) => OpeningBalanceListModel(
    data: List<OpeningBalanceModel>.from(json["data"].map((x) => OpeningBalanceModel.fromJson(x))),
  );
}

class OpeningBalanceModel {
  OpeningBalanceModel({
    this.id,
    this.date,
    this.openingBalance,
    this.closingBalance,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final DateTime? date;
  final String? openingBalance;
  final dynamic closingBalance;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory OpeningBalanceModel.fromJson(Map<String, dynamic> json) => OpeningBalanceModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    openingBalance: json["opening_balance"],
    closingBalance: json["closing_balance"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}
