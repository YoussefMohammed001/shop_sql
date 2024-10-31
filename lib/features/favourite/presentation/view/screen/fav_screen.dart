import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/models/categories_model.dart';
import 'package:shop_sql/core/widgets/note_item.dart';
import 'package:shop_sql/features/favourite/manager/favorite_cubit.dart';

class FavScreen extends StatefulWidget {
  FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final cubit = FavoriteCubit();

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
