import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:income_exapnce/Sereen/AddData/AddScreen.dart';
import 'package:income_exapnce/Sereen/Filter/View/showScreen.dart';

import 'Sereen/HomeScreen/HomeScreen.dart';



void main() {
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false, getPages: [
    GetPage(name: '/', page: () => Homescreen()),
    GetPage(name: '/income', page: () => AddDataScreen()),
    GetPage(name: '/transaction', page: () => HistoryScreen()),
  ]));
}