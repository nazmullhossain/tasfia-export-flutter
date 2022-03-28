import 'dart:convert';

ExpenseListModel expenseListModelFromJson(String str) => ExpenseListModel.fromJson(json.decode(str));

class ExpenseListModel {
  ExpenseListModel({
    this.data,
  });

  final List<ExpenseModel>? data;

  factory ExpenseListModel.fromJson(Map<String?, dynamic> json) => ExpenseListModel(
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
    this.expensesCategory,
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
  final ExpensesCategory? expensesCategory;

  factory ExpenseModel.fromJson(Map<String?, dynamic> json) => ExpenseModel(
    id: json["id"],
    expensesCategoryId: json["expenses_category_id"],
    name: json["name"],
    balance: json["balance"],
    amount: json["Amount"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
    expensesCategory: ExpensesCategory.fromJson(json["expenses_category"]),
  );
}

class ExpensesCategory {
  ExpensesCategory({
    this.id,
    this.name,
    this.remark,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? remark;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ExpensesCategory.fromJson(Map<String?, dynamic> json) => ExpensesCategory(
    id: json["id"],
    name: json["name"],
    remark: json["remark"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );

}
