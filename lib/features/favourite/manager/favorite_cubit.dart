import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_sql/core/data_base/shop_data_base.dart';
import 'package:shop_sql/core/models/categories_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());




}