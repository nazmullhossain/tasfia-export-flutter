import 'dart:convert';

SupplierModel supplierModelFromJson(String str) => SupplierModel.fromJson(json.decode(str));

class SupplierModel {
  SupplierModel({
    this.data,
  });
  final List<Supplier>? data;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
    data: List<Supplier>.from(json["data"].map((x) => Supplier.fromJson(x))),
  );
}

class Supplier {
  Supplier({
    this.id,
    this.companyId,
    this.name,
    this.email,
    this.personalPhone,
    this.optionalPhone,
    this.presentAddress,
    this.permanentAddress,
    this.balance,
    this.companyName,
    this.companyAddress,
    this.companyContactNo,
    this.reference,
    this.nid,
    this.photo,
    this.nationality,
    this.designation,
    this.country,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.totalPaymentAmount,
    this.totalDue,
    this.totalPurchaseAmount,
    this.purchase,
    this.previousDuePaymentHistory,
    this.company,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final dynamic email;
  final String? personalPhone;
  final dynamic optionalPhone;
  final String? presentAddress;
  final String? permanentAddress;
  final dynamic balance;
  final dynamic companyName;
  final dynamic companyAddress;
  final dynamic companyContactNo;
  final dynamic reference;
  final dynamic nid;
  final String? photo;
  final String? nationality;
  final String? designation;
  final dynamic country;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? totalPaymentAmount;
  final String? totalDue;
  final String? totalPurchaseAmount;
  final List<Purchase>? purchase;
  final List<dynamic>? previousDuePaymentHistory;
  final Company? company;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    companyId: json["company_id"],
    name: json["name"],
    email: json["email"],
    personalPhone: json["personal_phone"],
    optionalPhone: json["optional_phone"],
    presentAddress: json["present_address"],
    permanentAddress: json["permanent_address"],
    balance: json["balance"],
    companyName: json["company_name"],
    companyAddress: json["company_address"],
    companyContactNo: json["company_contact_no"],
    reference: json["reference"],
    nid: json["nid"],
    photo: json["photo"],
    nationality: json["nationality"],
    designation: json["designation"],
    country: json["country"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    totalPaymentAmount: json["total_payment_amount"],
    totalDue: json["total_due"],
    totalPurchaseAmount: json["total_purchase_amount"],
    purchase: List<Purchase>.from(json["purchase"].map((x) => Purchase.fromJson(x))),
    previousDuePaymentHistory: List<dynamic>.from(json["previous_due_payment_history"].map((x) => x)),
    company: Company.fromJson(json["company"]),
  );
}

class Company {
  Company({
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
  final String? companyContactNo;
  final String? country;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
