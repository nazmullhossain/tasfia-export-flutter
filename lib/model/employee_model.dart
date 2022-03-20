import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

class EmployeeModel {
  EmployeeModel({
    this.data,
  });
  final List<Employee>? data;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    data: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
  );
}

class Employee {
  Employee({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.salary,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? salary;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    salary: json["salary"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
