import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_sql/core/data_base/shop_data_base.dart';
import 'package:shop_sql/features/products/model/products_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  getProducts({required int catId}) async {
    emit(GetProductsLoading());
    List<ProductsModel> products = await ShopDatabase.getProduct(catId:catId );
    emit(GetProductsSuccess(products: products));
  }

  addProduct(ProductsModel productsModel) async {
    ShopDatabase.addProduct(productsModel);
    getProducts(catId: productsModel.catId);
  }

  deleteProduct({required int id, required int catId}) async {
    ShopDatabase.deleteProduct(id);
    getProducts(catId:catId);
  }

}