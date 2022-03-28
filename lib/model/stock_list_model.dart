import 'dart:convert';

StockListModel stockListModelFromJson(String str) => StockListModel.fromJson(json.decode(str));

class StockListModel {
  StockListModel({
    this.data,
  });

  final List<StockModel>? data;

  factory StockListModel.fromJson(Map<dynamic, dynamic> json) => StockListModel(
    data: List<StockModel>.from(json["data"].map((x) => StockModel.fromJson(x))),
  );
}

class StockModel {
  StockModel({
    this.id,
    this.purchaseId,
    this.createdBy,
    this.quantity,
    this.mainQuantity,
    this.status,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.purchase,
  });

  final int? id;
  final int? purchaseId;
  final dynamic createdBy;
  final dynamic quantity;
  final dynamic mainQuantity;
  final dynamic status;
  final dynamic date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Purchase? purchase;

  factory StockModel.fromJson(Map<dynamic, dynamic> json) => StockModel(
    id: json["id"],
    purchaseId: json["purchase_id"],
    createdBy: json["created_by"],
    quantity: json["quantity"],
    mainQuantity: json["main_quantity"],
    status: json["status"],
    date: json["date"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
    purchase: Purchase.fromJson(json["purchase"]),
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
    this.supplier,
  });

  final int? id;
  final int? productId;
  final int? supplierId;
  final dynamic createdBy;
  final dynamic quantity;
  final dynamic paymentMode;
  final dynamic mainQuantity;
  final int? status;
  final dynamic unitPrice;
  final dynamic totalPurchasPrice;
  final dynamic actualUnitPrice;
  final dynamic paymentAmount;
  final dynamic due;
  final dynamic actualPurchasPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final Supplier? supplier;

  factory Purchase.fromJson(Map<dynamic, dynamic> json) => Purchase(
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
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
    supplier: Supplier.fromJson(json["supplier"]),
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
  final dynamic chalanNo;
  final dynamic chalanNo2;
  final dynamic partyName;
  final dynamic quantity;
  final dynamic unitPrice;
  final dynamic colorName;
  final dynamic openTube;
  final dynamic slNo;
  final dynamic ggsm;
  final dynamic yarnCount;
  final dynamic yarnLotNo;
  final DateTime? fbRvDate;
  final dynamic batchProcessDate;
  final dynamic lotNo;
  final dynamic batchNo;
  final dynamic orderNo;
  final dynamic styleNo;
  final dynamic finishGsm;
  final dynamic fabricType;
  final dynamic cardNo;
  final dynamic roll;
  final dynamic dia;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
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
    fbRvDate: DateTime?.parse(json["fb_rv_date"]),
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
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
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
  });

  final int? id;
  final int? companyId;
  final dynamic name;
  final dynamic email;
  final dynamic personalPhone;
  final dynamic optionalPhone;
  final dynamic presentAddress;
  final dynamic permanentAddress;
  final dynamic balance;
  final dynamic companyName;
  final dynamic companyAddress;
  final dynamic companyContactNo;
  final dynamic reference;
  final dynamic nid;
  final dynamic photo;
  final dynamic nationality;
  final dynamic designation;
  final dynamic country;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Supplier.fromJson(Map<dynamic, dynamic> json) => Supplier(
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
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
  );
}
