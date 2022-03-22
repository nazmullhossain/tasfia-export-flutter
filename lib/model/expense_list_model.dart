import 'dart:convert';

ExpenseListModel expenseListModelFromJson(String str) => ExpenseListModel.fromJson(json.decode(str));

class ExpenseListModel {
  ExpenseListModel({
    this.data,
  });

  final List<ExpenseModel>? data;

  factory ExpenseListModel.fromJson(Map<String, dynamic> json) => ExpenseListModel(
    data: List<ExpenseModel>.from(json["data"].map((x) => ExpenseModel.fromJson(x))),
  );
}

class ExpenseModel {
  ExpenseModel({
    this.id,
    this.expensesCategoryId,
    this.name,
    this.balance,
    this.amount,
    this.remarks,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? expensesCategoryId;
  final String? name;
  final dynamic balance;
  final String? amount;
  final String? remarks;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: json["id"],
    expensesCategoryId: json["expenses_category_id"],
    name: json["name"],
    balance: json["balance"],
    amount: json["Amount"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  
}
