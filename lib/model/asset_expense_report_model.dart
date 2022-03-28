import 'dart:convert';

AssetExpenseReportModel assetExpenseReportModelFromJson(String str) => AssetExpenseReportModel.fromJson(json.decode(str));

class AssetExpenseReportModel {
  AssetExpenseReportModel({
    this.openingBalance,
    this.totalAsset,
    this.totalExpense,
    this.sales,
    this.purchase,
    this.asset,
    this.expense,
    this.advanceSell,
  });

  final OpeningBalance? openingBalance;
  final int? totalAsset;
  final int? totalExpense;
  final List<Sale>? sales;
  final List<dynamic>? purchase;
  final List<dynamic>? asset;
  final List<Expense>? expense;
  final List<dynamic>? advanceSell;

  factory AssetExpenseReportModel.fromJson(Map<String?, dynamic> json) => AssetExpenseReportModel(
    openingBalance: OpeningBalance.fromJson(json["opening_balance"]),
    totalAsset: json["total_asset"],
    totalExpense: json["total_expense"],
    sales: List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
    purchase: List<dynamic>.from(json["purchase"].map((x) => x)),
    asset: List<dynamic>.from(json["asset"].map((x) => x)),
    expense: List<Expense>.from(json["expense"].map((x) => Expense.fromJson(x))),
    advanceSell: List<dynamic>.from(json["advance_sell"].map((x) => x)),
  );

}

class Expense {
  Expense({
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

  factory Expense.fromJson(Map<String?, dynamic> json) => Expense(
    id: json["id"],
    expensesCategoryId: json["expenses_category_id"],
    name: json["name"],
    balance: json["balance"],
    amount: json["Amount"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}

class OpeningBalance {
  OpeningBalance({
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

  factory OpeningBalance.fromJson(Map<String?, dynamic> json) => OpeningBalance(
    id: json["id"],
    date: DateTime?.parse(json["date"]),
    openingBalance: json["opening_balance"],
    closingBalance: json["closing_balance"],
    status: json["status"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}

class Sale {
  Sale({
    this.id,
    this.salesId,
    this.customerId,
    this.amount,
    this.paymentMode,
    this.bankName,
    this.chequeNumber,
    this.chequeDueDate,
    this.bkashNumber,
    this.bkashTrnsId,
    this.cardNumber,
    this.cardExpireDate,
    this.remark,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final dynamic salesId;
  final int? customerId;
  final int? amount;
  final String? paymentMode;
  final dynamic bankName;
  final dynamic chequeNumber;
  final dynamic chequeDueDate;
  final dynamic bkashNumber;
  final dynamic bkashTrnsId;
  final dynamic cardNumber;
  final dynamic cardExpireDate;
  final dynamic remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Sale.fromJson(Map<String?, dynamic> json) => Sale(
    id: json["id"],
    salesId: json["sales_id"],
    customerId: json["customer_id"],
    amount: json["amount"],
    paymentMode: json["payment_mode"],
    bankName: json["bank_name"],
    chequeNumber: json["cheque_number"],
    chequeDueDate: json["cheque_due_date"],
    bkashNumber: json["bkash_number"],
    bkashTrnsId: json["bkash_trns_id"],
    cardNumber: json["card_number"],
    cardExpireDate: json["card_expire_date"],
    remark: json["remark"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}
