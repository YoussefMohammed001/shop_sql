import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/core/helpers/navigators.dart';
import 'package:shop_sql/features/cart/view/cart_arguments.dart';
import 'package:shop_sql/features/cart/view/screen/manager/cart_cubit.dart';
import 'package:pdf/widgets.dart' as pw;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.cartArguments});
  final CartArguments cartArguments;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cubit = CartCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CheckOutSuccessState) {
            final snackBar = SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
              content: Center(
                  child: Text(
                "Checkout Success",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              )),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Cart"),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible:
                        widget.cartArguments.cartModel.cartItems.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                          itemCount:
                              widget.cartArguments.cartModel.cartItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              padding: EdgeInsets.all(15.sp),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Text(widget.cartArguments.cartModel
                                        .cartItems[index].id
                                        .toString()),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.cartArguments.cartModel
                                              .cartItems[index].name,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "price: ${widget.cartArguments.cartModel.cartItems[index].price} \$",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Total: ${widget.cartArguments.cartModel.cartItems[index].totalItemPrice} \$",
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      widget.cartArguments.cartModel
                                          .cartItems[index].quantity++;
                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                        radius: 15.r,
                                        child: const Icon(Icons.add)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(widget.cartArguments.cartModel
                                      .cartItems[index].quantity
                                      .toString()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (widget.cartArguments.cartModel
                                              .cartItems[index].quantity >
                                          1) {
                                        widget.cartArguments.cartModel
                                            .cartItems[index].quantity--;
                                        setState(() {});
                                      } else {
                                        widget.cartArguments.cartModel.cartItems
                                            .removeAt(index);
                                        setState(() {});
                                      }
                                    },
                                    child: CircleAvatar(
                                        radius: 15.r,
                                        child: const Icon(Icons.remove)),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                    visible:  widget.cartArguments.cartModel.cartItems.isEmpty,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10.sp),
                      margin: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "invoice addedd successfully",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.getInvoice(id: cubit.invoiceId);

                                },
                                child: const Text("Generate PDF")),

                            ElevatedButton(
                                onPressed: () {
                                  pop(context);
                                },
                                child: const Text("New Invoice ")),
                            ElevatedButton(
                                onPressed: () {

                                },
                                child: const Text("List Invoice ")),
                          ]),
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.cartArguments.cartModel.cartItems.isNotEmpty,
                    child: Column(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.blueAccent[100]),
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total:",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                "${widget.cartArguments.cartModel.totalPrice} \$",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.blueAccent[200]),
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "vat: ${widget.cartArguments.cartModel.vat} %",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                "${widget.cartArguments.cartModel.vatAmount} \$",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.blueAccent[100]),
                          padding: EdgeInsets.all(15.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total price: ",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                "${widget.cartArguments.cartModel.totalAfterVat} \$",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 300.w,
                          height: 50.h,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent),
                              onPressed: () {
                                cubit.addInvoice(
                                    cartModel: widget.cartArguments.cartModel);
                              },
                              child: const Text(
                                "Checkout",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
