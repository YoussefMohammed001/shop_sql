import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/helpers/navigators.dart';
import 'package:shop_sql/features/favourite/model/line_voice_model.dart';
import 'package:shop_sql/features/products/model/products_model.dart';
import 'package:shop_sql/features/products/presentation/manager/products_cubit.dart';
import 'package:shop_sql/features/products/products_args.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key, required this.args});
  final ProductsArgs args;
  final cubit = ProductsCubit();
TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

final formKey = GlobalKey<FormState>();
@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getProducts(catId: args.catId),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return  AlertDialog(
                title: const Text("Add Product"),
                content: Container(
                  height: 380.h,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                    TextFormField(
                      validator: (v){
                        if(v!.isEmpty){
                          return "Name can't be empty";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Product Name",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      validator: (v){
                        if(v!.isEmpty){
                          return "Price can't be empty";
                        }

                        return null;
                      },
                      controller: priceController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Product price",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                        validator: (v){
                          if(v!.isEmpty){
                            return "Quantity can't be empty";
                          }
                          if(int.parse(v) <= 0){
                            return "Quantity must be greater than 0";
                          }
                          
                          return null;
                        },
                      controller: quantityController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Product quntity",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(onPressed: (){
                    if(formKey.currentState!.validate()){
                      cubit.addProduct(
                          ProductsModel(
                              name: nameController.text,
                              price: int.parse(priceController.text),
                              quantity: int.parse(quantityController.text),
                              catId: args.catId

                          )
                      );
                      pop(context);
                      nameController.clear();
                      priceController.clear();
                      quantityController.clear();
                    }

                    }, child: const Text("Add"))



                                  ],
                                  ),
                  ),
                ),
              );
            });


          },
          child: const Icon(Icons.add),
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
                                style: const TextStyle(
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
                                    Expanded(
                                      child: Text(

                                        "Quantity: ${state.products[index].quantity}",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,

                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                    Expanded(
                                      child: Text(

                                        "${state.products[index].price} EGP",
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17.sp
                                      ),
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              cubit.addToCart(
                                  lineInvoice: LineVoiceModel(

                                      productId:  state.products[index].id, quantity: 1,
                                    price: state.products[index].price,


                                  )
                              );
                            },
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.blue,
                            ),
                          ),


                          InkWell(
                            onTap: () {
                              cubit.deleteProduct(

                                  id: state.products[index].id,
                                  catId:state.products[index].catId );
                            },
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
