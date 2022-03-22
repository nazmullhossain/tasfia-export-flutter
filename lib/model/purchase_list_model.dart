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
    this.product,
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
  final Product? product;

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
    product: Product.fromJson(json["product"]),
  );
}

class Product {
  Product({
    this.id,
    this.productCategoryId,
    this.chalanNo,
    this.chalanNo2,
    this.partyName,
    this.quantity,
    this.unitPrice,
    this.colorName,
    this.openTube,
    this.slNo,
    this.ggsm,
    this.yarnCount,
    this.yarnLotNo,
    this.fbRvDate,
    this.batchProcessDate,
    this.lotNo,
    this.batchNo,
    this.orderNo,
    this.styleNo,
    this.finishGsm,
    this.fabricType,
    this.cardNo,
    this.roll,
    this.dia,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? productCategoryId;
  final String? chalanNo;
  final String? chalanNo2;
  final String? partyName;
  final String? quantity;
  final dynamic unitPrice;
  final String? colorName;
  final String? openTube;
  final dynamic slNo;
  final String? ggsm;
  final dynamic yarnCount;
  final dynamic yarnLotNo;
  final DateTime? fbRvDate;
  final DateTime? batchProcessDate;
  final dynamic lotNo;
  final dynamic batchNo;
  final dynamic orderNo;
  final dynamic styleNo;
  final String? finishGsm;
  final String? fabricType;
  final String? cardNo;
  final String? roll;
  final String? dia;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productCategoryId: json["product_category_id"],
    chalanNo: json["chalan_no"],
    chalanNo2: json["chalan_no_2"],
    partyName: json["party_name"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    colorName: json["color_name"],
    openTube: json["open_tube"],
    slNo: json["sl_no"],
    ggsm: json["ggsm"],
    yarnCount: json["yarn_count"],
    yarnLotNo: json["yarn_lot_no"],
    fbRvDate: json["fb_rv_date"] == null ? null : DateTime.parse(json["fb_rv_date"]),
    batchProcessDate: json["batch_process_date"] == null ? null : DateTime.parse(json["batch_process_date"]),
    lotNo: json["lot_no"],
    batchNo: json["batch_no"],
    orderNo: json["order_no"],
    styleNo: json["style_no"],
    finishGsm: json["finish_gsm"],
    fabricType: json["fabric_type"],
    cardNo: json["card_no"],
    roll: json["roll"],
    dia: json["dia"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
