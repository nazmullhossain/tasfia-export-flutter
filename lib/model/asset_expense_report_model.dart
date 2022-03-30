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
  final List<Asset>? asset;
  final List<Asset>? expense;
  final List<dynamic>? advanceSell;

  factory AssetExpenseReportModel.fromJson(Map<String?, dynamic> json) => AssetExpenseReportModel(
    openingBalance: OpeningBalance.fromJson(json["opening_balance"]),
    totalAsset: json["total_asset"],
    totalExpense: json["total_expense"],
    sales: List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
    purchase: List<dynamic>.from(json["purchase"].map((x) => x)),
    asset: List<Asset>.from(json["asset"].map((x) => Asset.fromJson(x))),
    expense: List<Asset>.from(json["expense"].map((x) => Asset.fromJson(x))),
    advanceSell: List<dynamic>.from(json["advance_sell"].map((x) => x)),
  );
}

class Asset {
  Asset({
    this.id,
    this.categoryId,
    this.name,
    this.balance,
    this.amount,
    this.remarks,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.expensesCategoryId,
    this.expensesCategory,
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
  final Category? category;
  final int? expensesCategoryId;
  final Category? expensesCategory;

  factory Asset.fromJson(Map<String?, dynamic> json) => Asset(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
    balance: json["balance"],
    amount: json["Amount"],
    remarks: json["remarks"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    expensesCategoryId: json["expenses_category_id"],
    expensesCategory: json["expenses_category"] == null ? null : Category.fromJson(json["expenses_category"]),
  );
}

class Category {
  Category({
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

  factory Category.fromJson(Map<String?, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    remark: json["remark"],
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
    this.customer,
    this.referenceSale,
  });

  final int? id;
  final int? salesId;
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
  final Customer? customer;
  final ReferenceSale? referenceSale;

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
    customer: Customer.fromJson(json["customer"]),
    referenceSale: ReferenceSale.fromJson(json["reference_sale"]),
  );
}

class Customer {
  Customer({
    this.id,
    this.companyId,
    this.name,
    this.type,
    this.email,
    this.personalPhone,
    this.optionalPhone,
    this.presentAddress,
    this.companyName,
    this.permanentAddress,
    this.balance,
    this.reference,
    this.nid,
    this.photo,
    this.nationality,
    this.designation,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final String? type;
  final dynamic email;
  final String? personalPhone;
  final dynamic optionalPhone;
  final String? presentAddress;
  final dynamic companyName;
  final String? permanentAddress;
  final String? balance;
  final dynamic reference;
  final dynamic nid;
  final String? photo;
  final String? nationality;
  final String? designation;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Customer.fromJson(Map<String?, dynamic> json) => Customer(
    id: json["id"],
    companyId: json["company_id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    personalPhone: json["personal_phone"],
    optionalPhone: json["optional_phone"],
    presentAddress: json["present_address"],
    companyName: json["company_name"],
    permanentAddress: json["permanent_address"],
    balance: json["balance"],
    reference: json["reference"],
    nid: json["nid"],
    photo: json["photo"],
    nationality: json["nationality"],
    designation: json["designation"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}

class ReferenceSale {
  ReferenceSale({
    this.id,
    this.customerId,
    this.salesExecutiveId,
    this.totalPrice,
    this.paymentAmount,
    this.due,
    this.labourBill,
    this.reference,
    this.salesDate,
    this.status,
    this.salesCode,
    this.profitOrLoss,
    this.date,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? customerId;
  final int? salesExecutiveId;
  final String? totalPrice;
  final String? paymentAmount;
  final String? due;
  final String? labourBill;
  final dynamic reference;
  final dynamic salesDate;
  final int? status;
  final String? salesCode;
  final String? profitOrLoss;
  final dynamic date;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ReferenceSale.fromJson(Map<String?, dynamic> json) => ReferenceSale(
    id: json["id"],
    customerId: json["customer_id"],
    salesExecutiveId: json["sales_executive_id"],
    totalPrice: json["total_price"],
    paymentAmount: json["payment_amount"],
    due: json["due"],
    labourBill: json["labour_bill"],
    reference: json["reference"],
    salesDate: json["sales_date"],
    status: json["status"],
    salesCode: json["sales_code"],
    profitOrLoss: json["profit_or_loss"],
    date: json["date"],
    createdBy: json["created_by"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}
