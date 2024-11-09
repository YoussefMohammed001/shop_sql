import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_sql/features/cart/view/cart_args.dart';

class CartScreen extends StatefulWidget {
 const  CartScreen({super.key, required this.args});
  final CartArgs args;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.args.cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(8.sp),
                  margin: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.args.cartList[index].name),
                          Text("price: ${widget.args.cartList[index].price}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          InkWell(
                            onTap: () {
                              widget.args.cartList[index].quantity++;
                              setState(() {});
                            },
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: Colors.blueAccent,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(widget.args.cartList[index].quantity.toString()),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                              if (widget.args.cartList[index].quantity > 1) {
                                widget.args.cartList[index].quantity--;
                                setState(() {});
                              } else {
                                widget.args.cartList.removeAt(index);
                                setState(() {});
                              }
                            },
                            child: CircleAvatar(
                                radius: 15.r,
                                backgroundColor: Colors.blueAccent,
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: () {
                                widget.args.cartList.removeAt(index);
                                setState(() {});
                            },
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.red,
                            ),
                          ),
                        ],

                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
                clipBehavior:   Clip.antiAliasWithSaveLayer,
                style:  ElevatedButton.styleFrom(

                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: (){}, child: const Text("Confirm",style: TextStyle(
              color: Colors.white,
            ),)),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
