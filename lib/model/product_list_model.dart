import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

class ProductListModel {
  ProductListModel({
    this.data,
  });

  final List<Product>? data;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
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
  final dynamic quantity;
  final dynamic unitPrice;
  final String? colorName;
  final String? openTube;
  final String? slNo;
  final String? ggsm;
  final String? yarnCount;
  final String? yarnLotNo;
  final dynamic fbRvDate;
  final dynamic batchProcessDate;
  final dynamic lotNo;
  final dynamic batchNo;
  final dynamic orderNo;
  final dynamic styleNo;
  final dynamic finishGsm;
  final String? fabricType;
  final String? cardNo;
  final dynamic roll;
  final dynamic dia;
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
    fbRvDate: json["fb_rv_date"],
    batchProcessDate: json["batch_process_date"],
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
