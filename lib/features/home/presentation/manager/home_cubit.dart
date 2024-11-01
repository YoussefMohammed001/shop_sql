import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_sql/core/data_base/shop_data_base.dart';
import 'package:shop_sql/core/models/categories_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  getCategories() async {
    emit(HomeLoadingState());
    ShopDatabase.getCategories().then((onValue){
      emit(HomeSuccessState(onValue));

    });

  }

  addCategory(CategoryModel categoryModel) async {
    ShopDatabase.addCategory(categoryModel);
    getCategories();
  }

  deleteCategory(int id) async {
    ShopDatabase.deleteCategory(id);
    getCategories();
  }

  updateCategory(CategoryModel categoryModel) async {
    ShopDatabase.updateCategory(categoryModel);
    getCategories();
  }


}
