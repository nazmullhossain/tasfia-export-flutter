import 'dart:convert';

AccountSummeryModel accountSummeryModelFromJson(String str) => AccountSummeryModel.fromJson(json.decode(str));

class AccountSummeryModel {
  AccountSummeryModel({
    this.profit,
    this.expense,
  });

  final dynamic profit;
  final dynamic expense;

  factory AccountSummeryModel.fromJson(Map<String, dynamic> json) => AccountSummeryModel(
    profit: json["profit"],
    expense: json["expense"],
  );
}
