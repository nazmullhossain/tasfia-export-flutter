import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeMenuModel{
  String title;
  IconData icon;
  Color color;
  HomeMenuModel({required this.title,required this.icon, required this.color});

  static List<HomeMenuModel> homeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'Customer', icon: LineAwesomeIcons.user_tie, color: Colors.orange),
    HomeMenuModel(title: 'Supplier', icon: LineAwesomeIcons.sync_icon, color: Colors.lightBlue),
    HomeMenuModel(title: 'Products', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Purchase', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Sales', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Stock', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'জমা হিসাব', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'খরচ হিসাব', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Advance Sell', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Employee Details', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Opening Balance', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
    HomeMenuModel(title: 'Report', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];
}