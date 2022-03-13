import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class HomeMenuModel{
  String title;
  IconData icon;
  Color color;
  HomeMenuModel({required this.title,required this.icon, required this.color});

  static List<HomeMenuModel> aggregatorHomeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'Merchant', icon: LineAwesomeIcons.user_tie, color: Colors.orange),
    HomeMenuModel(title: 'Transaction History', icon: LineAwesomeIcons.sync_icon, color: Colors.lightBlue),
    HomeMenuModel(title: 'Account', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];
  static List<HomeMenuModel> superAggregatorHomeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'Transaction History', icon: LineAwesomeIcons.sync_icon, color: Colors.lightBlue),
    HomeMenuModel(title: 'Account', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];

  static List<HomeMenuModel> merchantHomeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'New Request', icon: LineAwesomeIcons.hand_holding_us_dollar, color: Colors.orange),
    HomeMenuModel(title: 'Transaction History', icon: LineAwesomeIcons.sync_icon, color: Colors.lightBlue),
    HomeMenuModel(title: 'Account', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];
  static List<HomeMenuModel> superMerchantHomeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'Transaction History', icon: LineAwesomeIcons.sync_icon, color: Colors.lightBlue),
    HomeMenuModel(title: 'Account', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];

  static List<HomeMenuModel> superUserHomeMenuDataList = [
    HomeMenuModel(title: 'Dashboard', icon: LineAwesomeIcons.alternate_tachometer, color: Colors.purple),
    HomeMenuModel(title: 'Merchant', icon: LineAwesomeIcons.user_tie, color: Colors.orange),
    HomeMenuModel(title: 'Aggregator', icon: LineAwesomeIcons.user, color: Colors.lightBlue),
    // HomeMenuModel(title: 'Rules', icon: LineAwesomeIcons.gavel, color: Colors.blueAccent),
    HomeMenuModel(title: 'Account', icon: LineAwesomeIcons.user, color: Colors.lightGreen),
  ];
}