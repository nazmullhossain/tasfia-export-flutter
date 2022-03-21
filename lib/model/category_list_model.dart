import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

class CategoryListModel {
  CategoryListModel({
    this.data,
  });

  final List<CategoryModel>? data;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    data: List<CategoryModel>.from(json["data"].map((x) => CategoryModel.fromJson(x))),
  );
}

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final int? createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
