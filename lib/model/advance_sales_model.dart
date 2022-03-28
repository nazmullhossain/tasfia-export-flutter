import 'dart:convert';

AdvanceSaleListModel advanceSaleListModelFromJson(String str) => AdvanceSaleListModel.fromJson(json.decode(str));

class AdvanceSaleListModel {
  AdvanceSaleListModel({
    this.data,
  });

  final List<AdvanceSaleModel>? data;

  factory AdvanceSaleListModel.fromJson(Map<String?, dynamic> json) => AdvanceSaleListModel(
    data: List<AdvanceSaleModel>.from(json["data"].map((x) => AdvanceSaleModel.fromJson(x))),
  );
}

class AdvanceSaleModel {
  AdvanceSaleModel({
    this.id,
    this.partyId,
    this.productId,
    this.invoiceDate,
    this.dueDate,
    this.clientName,
    this.email,
    this.phone,
    this.address,
    this.projectDesc,
    this.subtotal,
    this.tax,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.party,
    this.product,
  });

  final int? id;
  final int? partyId;
  final int? productId;
  final DateTime? invoiceDate;
  final DateTime? dueDate;
  final dynamic clientName;
  final dynamic email;
  final dynamic phone;
  final dynamic address;
  final String? projectDesc;
  final String? subtotal;
  final String? tax;
  final String? totalAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Party? party;
  final Product? product;

  factory AdvanceSaleModel.fromJson(Map<String?, dynamic> json) => AdvanceSaleModel(
    id: json["id"],
    partyId: json["party_id"],
    productId: json["product_id"],
    invoiceDate: DateTime?.parse(json["invoice_date"]),
    dueDate: DateTime?.parse(json["due_date"]),
    clientName: json["client_name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    projectDesc: json["project_desc"],
    subtotal: json["subtotal"],
    tax: json["tax"],
    totalAmount: json["total_amount"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
    party: Party.fromJson(json["party"]),
    product: Product.fromJson(json["product"]),
  );
}

class Party {
  Party({
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
    this.company,
  });

  final int? id;
  final int? companyId;
  final String? name;
  final dynamic email;
  final dynamic personalPhone;
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
  final Company? company;

  factory Party.fromJson(Map<String?, dynamic> json) => Party(
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
  final dynamic companyContactNo;
  final String? country;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String?, dynamic> json) => Company(
    id: json["id"],
    companyName: json["company_name"],
    category: json["category"],
    companyAddress: json["company_address"],
    companyContactNo: json["company_contact_no"],
    country: json["country"],
    createdAt: DateTime?.parse(json["created_at"]),
    updatedAt: DateTime?.parse(json["updated_at"]),
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
  final dynamic chalanNo2;
  final String? partyName;
  final dynamic quantity;
  final dynamic unitPrice;
  final String? colorName;
  final String? openTube;
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
  final String? finishGsm;
  final String? fabricType;
  final String? cardNo;
  final String? roll;
  final String? dia;
  final dynamic createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Product.fromJson(Map<String?, dynamic> json) => Product(
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
