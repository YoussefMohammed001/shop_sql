import 'package:flutter/material.dart';
import 'package:shop_sql/app.dart';
import 'package:shop_sql/core/data_base/shop_data_base.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ShopDatabase.init();
  runApp(const MyApp());
}











