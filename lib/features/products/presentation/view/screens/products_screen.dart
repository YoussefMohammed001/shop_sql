import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/features/products/presentation/manager/products_cubit.dart';
import 'package:shop_sql/features/products/products_args.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key, required this.args});
  final ProductsArgs args;
  final cubit = ProductsCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getProducts(catId: args.catId),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(args.catName),
        ),
        body: Column(
          children: [
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is GetProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetProductsSuccess) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) => Container(
                      margin:
                          EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                state.products[index].id.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.products[index].name,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Quantity: ${state.products[index].quantity}",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "Price: ${state.products[index].price}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17.sp
                                    ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.blue,
                          ),
                          InkWell(

                            onTap: () {
                              cubit.deleteProduct(

                                  id: state.products[index].id,
                                  catId:state.products[index].catId );
                            },
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
